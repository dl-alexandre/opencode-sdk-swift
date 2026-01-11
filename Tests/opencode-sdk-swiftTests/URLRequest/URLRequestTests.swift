import Foundation
import Testing
@testable import opencode_sdk_swift

@Test func urlRequestBuildsPathAndQuery() async throws {
    let client = TestHelpers.makeClient(baseURL: "https://api.example.com/v1")
    let request = TestHelpers.makeRequest(
        path: "sessions",
        queryItems: [URLQueryItem(name: "limit", value: "10")]
    )
    
    let urlRequest = try client.makeURLRequest(from: request, bodyData: nil)
    
    #expect(urlRequest.url?.absoluteString == "https://api.example.com/v1/sessions?limit=10")
    #expect(urlRequest.httpMethod == "GET")
    #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == "Bearer test-key")
}

@Test func urlRequestEncodesBodyAndHeaders() async throws {
    let client = TestHelpers.makeClient(
        baseURL: "https://api.example.com",
        apiKey: "",
        userAgent: "opencode-swift-tests/0.1"
    )
    let request = TestHelpers.makeRequest(
        method: .post,
        path: "/prompts",
        headers: ["X-Custom": "value"],
        body: AnyEncodable(SimpleBody(message: "hi"))
    )
    
    let encoder = TestHelpers.makeEncoder()
    let bodyData = try encoder.encode(SimpleBody(message: "hi"))
    let urlRequest = try client.makeURLRequest(from: request, bodyData: bodyData)
    
    #expect(urlRequest.value(forHTTPHeaderField: "User-Agent") == "opencode-swift-tests/0.1")
    #expect(urlRequest.value(forHTTPHeaderField: "X-Custom") == "value")
    #expect(urlRequest.value(forHTTPHeaderField: "Content-Type") == "application/json")
    #expect(urlRequest.value(forHTTPHeaderField: "Accept") == "application/json")
    #expect(urlRequest.httpBody != nil)
}

@Test func urlRequestNormalizesPath() async throws {
    let client = TestHelpers.makeClient(baseURL: "https://api.example.com/v1")
    
    let request1 = TestHelpers.makeRequest(path: "sessions")
    let urlRequest1 = try client.makeURLRequest(from: request1, bodyData: nil)
    #expect(urlRequest1.url?.absoluteString.contains("/v1/sessions") == true)
    
    let request2 = TestHelpers.makeRequest(path: "/sessions")
    let urlRequest2 = try client.makeURLRequest(from: request2, bodyData: nil)
    #expect(urlRequest2.url?.absoluteString.contains("/v1/sessions") == true)
}

@Test func urlRequestEncodesQueryItems() async throws {
    let client = TestHelpers.makeClient()
    let request = TestHelpers.makeRequest(
        path: "/test",
        queryItems: [
            URLQueryItem(name: "limit", value: "10"),
            URLQueryItem(name: "offset", value: "20"),
            URLQueryItem(name: "filter", value: "active")
        ]
    )
    
    let urlRequest = try client.makeURLRequest(from: request, bodyData: nil)
    let urlString = urlRequest.url?.absoluteString ?? ""
    #expect(urlString.contains("limit=10"))
    #expect(urlString.contains("offset=20"))
    #expect(urlString.contains("filter=active"))
}
