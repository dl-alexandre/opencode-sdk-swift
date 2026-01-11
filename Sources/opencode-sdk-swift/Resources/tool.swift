import Foundation

@available(macOS 12.0, *)
extension OpenCodeClient {
    public struct Tool {
        let client: OpenCodeClient
        
        public func ids(directory: String? = nil) async throws -> [String] {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<[String]>(
                method: .get,
                path: "/experimental/tool/ids",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
        
        public func list(provider: String, model: String, directory: String? = nil) async throws -> [ToolListItem] {
            var queryItems: [URLQueryItem] = []
            queryItems.append(URLQueryItem(name: "provider", value: provider))
            queryItems.append(URLQueryItem(name: "model", value: model))
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<[ToolListItem]>(
                method: .get,
                path: "/experimental/tool",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
    }
    
    public var tool: Tool {
        Tool(client: self)
    }
}
