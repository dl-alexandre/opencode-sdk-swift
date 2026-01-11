import Foundation

@available(macOS 12.0, *)
extension OpenCodeClient {
    public struct MCP {
        let client: OpenCodeClient
        
        public func status(directory: String? = nil) async throws -> [String: MCPStatus] {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<[String: MCPStatus]>(
                method: .get,
                path: "/mcp",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
        
        public func add(directory: String? = nil, request: McpAddRequest) async throws -> [String: MCPStatus] {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let apiRequest = OpenCodeRequest<[String: MCPStatus]>(
                method: .post,
                path: "/mcp",
                queryItems: queryItems,
                body: AnyEncodable(request)
            )
            return try await client.send(apiRequest)
        }
        
        public func connect(name: String, directory: String? = nil) async throws -> Bool {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<Bool>(
                method: .post,
                path: "/mcp/\(name)/connect",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
        
        public func disconnect(name: String, directory: String? = nil) async throws -> Bool {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<Bool>(
                method: .post,
                path: "/mcp/\(name)/disconnect",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
        
        public func authStart(name: String, directory: String? = nil) async throws -> ProviderAuthAuthorization {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<ProviderAuthAuthorization>(
                method: .post,
                path: "/mcp/\(name)/auth",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
        
        public func authRemove(name: String, directory: String? = nil) async throws -> Bool {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<Bool>(
                method: .delete,
                path: "/mcp/\(name)/auth",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
        
        public func authCallback(name: String, directory: String? = nil, code: String) async throws -> MCPStatus {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let apiRequest = OpenCodeRequest<MCPStatus>(
                method: .post,
                path: "/mcp/\(name)/auth/callback",
                queryItems: queryItems,
                body: AnyEncodable(["code": code])
            )
            return try await client.send(apiRequest)
        }
        
        public func authAuthenticate(name: String, directory: String? = nil) async throws -> MCPStatus {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<MCPStatus>(
                method: .post,
                path: "/mcp/\(name)/auth/authenticate",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
    }
    
    public var mcp: MCP {
        MCP(client: self)
    }
}
