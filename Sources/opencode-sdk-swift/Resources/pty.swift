import Foundation

@available(macOS 12.0, *)
extension OpenCodeClient {
    public struct Pty {
        let client: OpenCodeClient
        
        public func list(directory: String? = nil) async throws -> [opencode_sdk_swift.Pty] {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<[opencode_sdk_swift.Pty]>(
                method: .get,
                path: "/pty",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
        
        public func create(directory: String? = nil, request: PtyCreateRequest) async throws -> opencode_sdk_swift.Pty {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let apiRequest = OpenCodeRequest<opencode_sdk_swift.Pty>(
                method: .post,
                path: "/pty",
                queryItems: queryItems,
                body: AnyEncodable(request)
            )
            return try await client.send(apiRequest)
        }
        
        public func get(ptyID: String, directory: String? = nil) async throws -> opencode_sdk_swift.Pty {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<opencode_sdk_swift.Pty>(
                method: .get,
                path: "/pty/\(ptyID)",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
        
        public func update(ptyID: String, directory: String? = nil, request: PtyUpdateRequest) async throws -> opencode_sdk_swift.Pty {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let apiRequest = OpenCodeRequest<opencode_sdk_swift.Pty>(
                method: .put,
                path: "/pty/\(ptyID)",
                queryItems: queryItems,
                body: AnyEncodable(request)
            )
            return try await client.send(apiRequest)
        }
        
        public func remove(ptyID: String, directory: String? = nil) async throws -> Bool {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<Bool>(
                method: .delete,
                path: "/pty/\(ptyID)",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
        
        public func connect(ptyID: String, directory: String? = nil) async throws -> Bool {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<Bool>(
                method: .get,
                path: "/pty/\(ptyID)/connect",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
    }
    
    public var pty: Pty {
        Pty(client: self)
    }
}
