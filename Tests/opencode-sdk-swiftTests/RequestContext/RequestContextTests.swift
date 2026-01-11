import Foundation
import Testing
@testable import opencode_sdk_swift

@available(macOS 12.0, *)
@Test func requestContextPropagatesRequestID() async throws {
    let client = TestHelpers.makeClient()
    let testRequestID = "test-request-123"
    
    try await RequestContext.$requestID.withValue(testRequestID) {
        let request = TestHelpers.makeRequest()
        let urlRequest = try client.makeURLRequest(from: request, bodyData: nil)
        #expect(urlRequest.value(forHTTPHeaderField: "X-Request-ID") == testRequestID)
    }
}

@available(macOS 12.0, *)
@Test func requestContextPropagatesCorrelationID() async throws {
    let client = TestHelpers.makeClient()
    let testCorrelationID = "test-correlation-456"
    
    try await RequestContext.$correlationID.withValue(testCorrelationID) {
        let request = TestHelpers.makeRequest()
        let urlRequest = try client.makeURLRequest(from: request, bodyData: nil)
        #expect(urlRequest.value(forHTTPHeaderField: "X-Correlation-ID") == testCorrelationID)
    }
}

@available(macOS 12.0, *)
@Test func requestContextGeneratesRequestIDWhenMissing() async throws {
    let client = TestHelpers.makeClient()
    let request = TestHelpers.makeRequest()
    
    let urlRequest = try client.makeURLRequest(from: request, bodyData: nil)
    let requestID = urlRequest.value(forHTTPHeaderField: "X-Request-ID")
    #expect(requestID != nil)
    #expect(requestID?.isEmpty == false)
}
