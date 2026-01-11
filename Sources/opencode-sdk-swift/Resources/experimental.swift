import Foundation

@available(macOS 12.0, *)
extension OpenCodeClient {
    public struct Experimental {
        let client: OpenCodeClient
        
        public func resourceList(directory: String? = nil) async throws -> [String: McpResource] {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<[String: McpResource]>(
                method: .get,
                path: "/experimental/resource",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
    }
    
    public var experimental: Experimental {
        Experimental(client: self)
    }
}
