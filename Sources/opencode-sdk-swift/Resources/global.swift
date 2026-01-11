import Foundation

@available(macOS 12.0, *)
extension OpenCodeClient {
    public struct Global {
        let client: OpenCodeClient
        
        public func health(directory: String? = nil) async throws -> HealthResponse {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<HealthResponse>(
                method: .get,
                path: "/global/health",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
        
        public func dispose(directory: String? = nil) async throws -> Bool {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<Bool>(
                method: .post,
                path: "/global/dispose",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
    }
    
    public var global: Global {
        Global(client: self)
    }
}
