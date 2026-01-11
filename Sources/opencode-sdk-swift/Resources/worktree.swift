import Foundation

@available(macOS 12.0, *)
extension OpenCodeClient {
    public struct Worktree {
        let client: OpenCodeClient
        
        public func create(directory: String? = nil, request: WorktreeCreateInput) async throws -> opencode_sdk_swift.Worktree {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let apiRequest = OpenCodeRequest<opencode_sdk_swift.Worktree>(
                method: .post,
                path: "/experimental/worktree",
                queryItems: queryItems,
                body: AnyEncodable(request)
            )
            return try await client.send(apiRequest)
        }
        
        public func list(directory: String? = nil) async throws -> [String] {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<[String]>(
                method: .get,
                path: "/experimental/worktree",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
    }
    
    public var worktree: Worktree {
        Worktree(client: self)
    }
}
