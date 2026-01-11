import Foundation

@available(macOS 12.0, *)
public enum RequestContext {
    @TaskLocal static var requestID: String?
    @TaskLocal static var correlationID: String?
    @TaskLocal static var userID: String?
}

public enum OpenCodeHTTPMethod: String, Sendable {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public struct OpenCodeRequest<Response: Decodable>: Sendable {
    public let method: OpenCodeHTTPMethod
    public let path: String
    public let queryItems: [URLQueryItem]
    public let headers: [String: String]
    public let body: AnyEncodable?

    public init(
        method: OpenCodeHTTPMethod,
        path: String,
        queryItems: [URLQueryItem] = [],
        headers: [String: String] = [:],
        body: AnyEncodable? = nil
    ) {
        self.method = method
        self.path = path
        self.queryItems = queryItems
        self.headers = headers
        self.body = body
    }
}

public struct AnyEncodable: Encodable, Sendable {
    private let encodeBlock: @Sendable (Encoder) throws -> Void

    public init<T: Encodable & Sendable>(_ value: T) {
        let encodeMethod = value.encode
        self.encodeBlock = { @Sendable encoder in
            try encodeMethod(encoder)
        }
    }

    public func encode(to encoder: Encoder) throws {
        try encodeBlock(encoder)
    }
}

public struct EmptyResponse: Decodable, Sendable {
    public init() {}
}
