import Foundation
@testable import opencode_sdk_swift

struct SimpleBody: Codable, Sendable {
    let message: String
}

struct TestHelpers {
    static func makeClient(
        baseURL: String = "https://api.example.com",
        apiKey: String? = "test-key",
        apiKeyPrefix: String? = "Bearer",
        userAgent: String? = nil
    ) -> OpenCodeClient {
        let config = OpenCodeConfiguration(
            baseURL: URL(string: baseURL)!,
            apiKey: apiKey,
            apiKeyPrefix: apiKeyPrefix,
            userAgent: userAgent
        )
        return OpenCodeClient(configuration: config)
    }
    
    static func makeRequest(
        method: OpenCodeHTTPMethod = .get,
        path: String = "/test",
        queryItems: [URLQueryItem] = [],
        headers: [String: String] = [:],
        body: AnyEncodable? = nil
    ) -> OpenCodeRequest<EmptyResponse> {
        OpenCodeRequest(
            method: method,
            path: path,
            queryItems: queryItems,
            headers: headers,
            body: body
        )
    }
    
    static func makeEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }
    
    static func makeDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
}
