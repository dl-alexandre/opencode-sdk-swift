import Foundation
import Testing
@testable import opencode_sdk_swift

@Test func configurationApiKeyWithPrefix() async throws {
    let client = TestHelpers.makeClient(apiKeyPrefix: "Custom")
    let request = TestHelpers.makeRequest()
    let urlRequest = try client.makeURLRequest(from: request, bodyData: nil)
    #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == "Custom test-key")
}

@Test func configurationApiKeyWithoutPrefix() async throws {
    let client = TestHelpers.makeClient(apiKeyPrefix: nil)
    let request = TestHelpers.makeRequest()
    let urlRequest = try client.makeURLRequest(from: request, bodyData: nil)
    #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == "test-key")
}

@Test func configurationEmptyApiKey() async throws {
    let client = TestHelpers.makeClient(apiKey: "")
    let request = TestHelpers.makeRequest()
    let urlRequest = try client.makeURLRequest(from: request, bodyData: nil)
    #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == nil)
}

@Test func configurationHttpMethodValues() async throws {
    #expect(OpenCodeHTTPMethod.get.rawValue == "GET")
    #expect(OpenCodeHTTPMethod.post.rawValue == "POST")
    #expect(OpenCodeHTTPMethod.put.rawValue == "PUT")
    #expect(OpenCodeHTTPMethod.patch.rawValue == "PATCH")
    #expect(OpenCodeHTTPMethod.delete.rawValue == "DELETE")
}
