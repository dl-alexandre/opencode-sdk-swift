import Foundation
import Testing
@testable import opencode_sdk_swift

@Test func concurrencyCancellationPropagates() async throws {
    let client = TestHelpers.makeClient()
    
    let task = Task {
        let request = TestHelpers.makeRequest()
        return try await client.send(request)
    }
    
    task.cancel()
    
    do {
        _ = try await task.value
        Issue.record("Expected cancellation error")
    } catch is CancellationError {
        #expect(true)
    } catch {
        Issue.record("Expected CancellationError, got \(type(of: error))")
    }
}

@Test func concurrencyBatchSendsMultipleRequests() async throws {
    let client = TestHelpers.makeClient()
    
    let requests = [
        TestHelpers.makeRequest(path: "/test1"),
        TestHelpers.makeRequest(path: "/test2"),
        TestHelpers.makeRequest(path: "/test3")
    ]
    
    let results = try await client.sendBatch(requests)
    #expect(results.count == 3)
}

@Test func concurrencyBatchWithMaxConcurrency() async throws {
    let client = TestHelpers.makeClient()
    
    let requests = [
        TestHelpers.makeRequest(path: "/test1"),
        TestHelpers.makeRequest(path: "/test2"),
        TestHelpers.makeRequest(path: "/test3")
    ]
    
    let results = try await client.sendBatch(requests, maxConcurrency: 2)
    #expect(results.count == 3)
}
