import Foundation
import Testing
@testable import opencode_sdk_swift

@Test func edgeCaseEmptyResponseHandling() async throws {
    let client = TestHelpers.makeClient()
    let request = TestHelpers.makeRequest(method: .delete)
    
    let urlRequest = try client.makeURLRequest(from: request, bodyData: nil)
    #expect(urlRequest.httpMethod == "DELETE")
    #expect(urlRequest.httpBody == nil)
}
