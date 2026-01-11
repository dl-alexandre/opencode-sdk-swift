import Foundation

@available(macOS 12.0, *)
extension OpenCodeClient {
    public struct Find {
        let client: OpenCodeClient
        
        @preconcurrency
        public func text(pattern: String, directory: String? = nil) async throws -> [[String: AnyCodable]] {
            var queryItems: [URLQueryItem] = []
            queryItems.append(URLQueryItem(name: "pattern", value: pattern))
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<[[String: AnyCodable]]>(
                method: .get,
                path: "/find",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
        
        public func files(query: String, directory: String? = nil, dirs: Bool? = nil, type: String? = nil, limit: Int? = nil) async throws -> [String] {
            var queryItems: [URLQueryItem] = []
            queryItems.append(URLQueryItem(name: "query", value: query))
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            if let dirs = dirs {
                queryItems.append(URLQueryItem(name: "dirs", value: dirs ? "true" : "false"))
            }
            if let type = type {
                queryItems.append(URLQueryItem(name: "type", value: type))
            }
            if let limit = limit {
                queryItems.append(URLQueryItem(name: "limit", value: String(limit)))
            }
            let request = OpenCodeRequest<[String]>(
                method: .get,
                path: "/find/file",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
        
        public func symbols(query: String, directory: String? = nil) async throws -> [Symbol] {
            var queryItems: [URLQueryItem] = []
            queryItems.append(URLQueryItem(name: "query", value: query))
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<[Symbol]>(
                method: .get,
                path: "/find/symbol",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
    }
    
    public var find: Find {
        Find(client: self)
    }
}
