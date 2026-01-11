import Foundation

@available(macOS 12.0, *)
extension OpenCodeClient {
    public struct Path {
        let client: OpenCodeClient
        
        public func get(directory: String? = nil) async throws -> opencode_sdk_swift.Path {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<opencode_sdk_swift.Path>(
                method: .get,
                path: "/path",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
    }
    
    public var path: Path {
        Path(client: self)
    }
}
