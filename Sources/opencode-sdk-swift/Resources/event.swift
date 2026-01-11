import Foundation

@available(macOS 12.0, *)
extension OpenCodeClient {
    public struct Event {
        let client: OpenCodeClient
        
        @preconcurrency
        public func subscribe(directory: String? = nil) async throws -> AsyncThrowingStream<String, Error> {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            var urlComponents = URLComponents(
                url: client.configuration.baseURL,
                resolvingAgainstBaseURL: false
            )
            urlComponents?.path = "/event"
            if !queryItems.isEmpty {
                urlComponents?.queryItems = queryItems
            }
            guard let url = urlComponents?.url else {
                throw OpenCodeError.invalidURL
            }
            let urlRequest: URLRequest = {
                var request = URLRequest(url: url, timeoutInterval: .infinity)
                request.httpMethod = "GET"
                request.setValue("text/event-stream", forHTTPHeaderField: "Accept")
                return request
            }()
            
            return AsyncThrowingStream { continuation in
                let task = Task {
                    do {
                        let session = URLSession.shared
                        let (asyncBytes, _) = try await session.bytes(for: urlRequest)
                        for try await line in asyncBytes.lines {
                            continuation.yield(line)
                        }
                        continuation.finish()
                    } catch {
                        continuation.finish(throwing: error)
                    }
                }
                continuation.onTermination = { @Sendable _ in
                    task.cancel()
                }
            }
        }
    }
    
    public var event: Event {
        Event(client: self)
    }
}
