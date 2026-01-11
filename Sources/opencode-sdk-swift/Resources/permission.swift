import Foundation

@available(macOS 12.0, *)
extension OpenCodeClient {
    public struct Permission {
        let client: OpenCodeClient
        
        public func list(directory: String? = nil) async throws -> [PermissionRequest] {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<[PermissionRequest]>(
                method: .get,
                path: "/permission",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
        
        public func reply(requestID: String, directory: String? = nil, request: PermissionReplyRequest) async throws -> Bool {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let apiRequest = OpenCodeRequest<Bool>(
                method: .post,
                path: "/permission/\(requestID)/reply",
                queryItems: queryItems,
                body: AnyEncodable(request)
            )
            return try await client.send(apiRequest)
        }
    }
    
    public var permission: Permission {
        Permission(client: self)
    }
}
