import Foundation
import Testing
@testable import opencode_sdk_swift

@Test func errorHandlingInvalidURL() async throws {
    let client = TestHelpers.makeClient()
    
    var urlComponents = URLComponents(
        url: URL(string: "https://api.example.com")!,
        resolvingAgainstBaseURL: false
    )
    urlComponents?.path = "/valid"
    urlComponents?.queryItems = [URLQueryItem(name: "invalid", value: "\u{0000}")]
    
    let request = TestHelpers.makeRequest(
        queryItems: urlComponents?.queryItems ?? []
    )
    
    do {
        _ = try client.makeURLRequest(from: request, bodyData: nil)
        Issue.record("Expected invalidURL error")
    } catch let error as OpenCodeError {
        if case .invalidURL = error {
            #expect(true)
        } else {
            Issue.record("Expected invalidURL, got \(error)")
        }
    }
}

@Test func errorHandlingEncodingFailed() async throws {
    struct NonEncodable: Encodable {
        func encode(to encoder: Encoder) throws {
            throw NSError(domain: "test", code: 1)
        }
    }
    
    let client = TestHelpers.makeClient()
    let request = TestHelpers.makeRequest(
        method: .post,
        body: AnyEncodable(NonEncodable())
    )
    
    do {
        _ = try await client.send(request)
        Issue.record("Expected encodingFailed error")
    } catch let error as OpenCodeError {
        if case .encodingFailed = error {
            #expect(true)
        } else {
            Issue.record("Expected encodingFailed, got \(error)")
        }
    }
}

@Test func errorHandlingErrorDescriptions() async throws {
    let invalidURL = OpenCodeError.invalidURL
    #expect(invalidURL.errorDescription == "Invalid URL")
    
    let invalidResponse = OpenCodeError.invalidResponse(statusCode: 404, data: Data())
    #expect(invalidResponse.errorDescription?.contains("404") == true)
    
    let encodingFailed = OpenCodeError.encodingFailed(underlying: NSError(domain: "test", code: 1))
    #expect(encodingFailed.errorDescription?.contains("Failed to encode") == true)
    
    let decodingFailed = OpenCodeError.decodingFailed(underlying: NSError(domain: "test", code: 1), data: Data())
    #expect(decodingFailed.errorDescription?.contains("Failed to decode") == true)
    
    let transportFailed = OpenCodeError.transportFailed(underlying: NSError(domain: "test", code: 1))
    #expect(transportFailed.errorDescription?.contains("Transport error") == true)
}
