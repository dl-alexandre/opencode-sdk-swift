import Foundation

@available(macOS 12.0, *)
public actor OpenCodeClient {
    public let configuration: OpenCodeConfiguration

    nonisolated private let urlSession: URLSession
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    public init(
        configuration: OpenCodeConfiguration,
        session: URLSession = .shared,
        encoder: JSONEncoder = JSONEncoder(),
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.configuration = configuration
        self.urlSession = session
        self.encoder = encoder
        self.decoder = decoder

        self.encoder.dateEncodingStrategy = .iso8601
        self.decoder.dateDecodingStrategy = .iso8601
    }

    public func send<Response: Decodable>(
        _ request: OpenCodeRequest<Response>
    ) async throws -> Response {
        try Task.checkCancellation()
        
        var headers = request.headers
        let requestID = RequestContext.requestID ?? UUID().uuidString
        let correlationID = RequestContext.correlationID
        
        if let correlationID = correlationID {
            headers["X-Correlation-ID"] = correlationID
        }
        headers["X-Request-ID"] = requestID
        
        let requestWithContext = OpenCodeRequest<Response>(
            method: request.method,
            path: request.path,
            queryItems: request.queryItems,
            headers: headers,
            body: request.body
        )
        
        let bodyData: Data?
        if let body = request.body {
            do {
                bodyData = try encoder.encode(body)
            } catch {
                throw OpenCodeError.encodingFailed(underlying: error)
            }
        } else {
            bodyData = nil
        }
        
        let urlRequest = try makeURLRequest(from: requestWithContext, bodyData: bodyData)

        let data: Data
        let response: URLResponse
        do {
            (data, response) = try await urlSession.data(for: urlRequest)
        } catch {
            if Task.isCancelled {
                throw CancellationError()
            }
            throw OpenCodeError.transportFailed(underlying: error)
        }

        try Task.checkCancellation()

        guard let httpResponse = response as? HTTPURLResponse else {
            throw OpenCodeError.invalidResponse(statusCode: -1, data: data)
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw OpenCodeError.invalidResponse(statusCode: httpResponse.statusCode, data: data)
        }

        if data.isEmpty, Response.self == EmptyResponse.self {
            return EmptyResponse() as! Response
        }

        do {
            return try decoder.decode(Response.self, from: data)
        } catch {
            throw OpenCodeError.decodingFailed(underlying: error, data: data)
        }
    }

    public func send(_ request: OpenCodeRequest<EmptyResponse>) async throws {
        func callGeneric<R: Decodable>(_ req: OpenCodeRequest<R>) async throws -> R {
            return try await send(req)
        }
        _ = try await callGeneric(request)
    }

    public func sendBatch<Response: Decodable & Sendable>(
        _ requests: [OpenCodeRequest<Response>]
    ) async throws -> [Response] {
        try await withThrowingTaskGroup(of: Response.self) { group in
            for request in requests {
                group.addTask {
                    try await self.send(request)
                }
            }
            
            var results: [Response] = []
            for try await result in group {
                results.append(result)
            }
            return results
        }
    }
    
    public func sendBatch<Response: Decodable & Sendable>(
        _ requests: [OpenCodeRequest<Response>],
        maxConcurrency: Int
    ) async throws -> [Response] {
        let client = self
        return try await withThrowingTaskGroup(of: Response.self) { group in
            var index = 0
            var results: [Response] = []
            results.reserveCapacity(requests.count)
            
            while index < requests.count {
                let batchSize = min(maxConcurrency, requests.count - index)
                
                for i in 0..<batchSize {
                    let request = requests[index + i]
                    group.addTask {
                        try await client.send(request)
                    }
                }
                
                for _ in 0..<batchSize {
                    if let result = try await group.next() {
                        results.append(result)
                    }
                }
                
                index += batchSize
            }
            
            return results
        }
    }

    nonisolated func makeURLRequest<Response: Decodable>(
        from request: OpenCodeRequest<Response>,
        bodyData: Data?
    ) throws -> URLRequest {
        var urlComponents = URLComponents(
            url: configuration.baseURL,
            resolvingAgainstBaseURL: false
        )
        let normalizedPath = request.path.hasPrefix("/") ? request.path : "/\(request.path)"
        let existingPath = urlComponents?.path ?? ""
        urlComponents?.path = existingPath + normalizedPath
        if !request.queryItems.isEmpty {
            urlComponents?.queryItems = request.queryItems
        }

        guard let url = urlComponents?.url else {
            throw OpenCodeError.invalidURL
        }

        var urlRequest = URLRequest(url: url, timeoutInterval: configuration.timeout)
        urlRequest.httpMethod = request.method.rawValue

        var headers = request.headers
        if !configuration.apiKey.isEmpty {
            let value: String
            if let prefix = configuration.apiKeyPrefix, !prefix.isEmpty {
                value = "\(prefix) \(configuration.apiKey)"
            } else {
                value = configuration.apiKey
            }
            headers[configuration.apiKeyHeader] = value
        }

        if let userAgent = configuration.userAgent, !userAgent.isEmpty {
            headers["User-Agent"] = userAgent
        }

        if let bodyData = bodyData {
            urlRequest.httpBody = bodyData
            headers["Content-Type"] = "application/json"
        }

        headers["Accept"] = "application/json"
        urlRequest.allHTTPHeaderFields = headers
        return urlRequest
    }
}
