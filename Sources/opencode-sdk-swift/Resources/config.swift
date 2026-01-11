import Foundation

@available(macOS 12.0, *)
extension OpenCodeClient {
    public struct Config {
        let client: OpenCodeClient
        
        public func get(directory: String? = nil) async throws -> opencode_sdk_swift.Config {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<opencode_sdk_swift.Config>(
                method: .get,
                path: "/config",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
        
        public func update(directory: String? = nil, request: opencode_sdk_swift.Config) async throws -> opencode_sdk_swift.Config {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let apiRequest = OpenCodeRequest<opencode_sdk_swift.Config>(
                method: .patch,
                path: "/config",
                queryItems: queryItems,
                body: AnyEncodable(request)
            )
            return try await client.send(apiRequest)
        }
        
        public func providers(directory: String? = nil) async throws -> [String: opencode_sdk_swift.Provider] {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<[String: opencode_sdk_swift.Provider]>(
                method: .get,
                path: "/config/providers",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
    }
    
    public var config: Config {
        Config(client: self)
    }
}
