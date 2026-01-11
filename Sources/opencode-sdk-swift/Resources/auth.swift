import Foundation

@available(macOS 12.0, *)
extension OpenCodeClient {
    public struct Auth {
        let client: OpenCodeClient
        
        public func set(providerID: String, directory: String? = nil, request: opencode_sdk_swift.Auth) async throws -> Bool {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let apiRequest = OpenCodeRequest<Bool>(
                method: .put,
                path: "/auth/\(providerID)",
                queryItems: queryItems,
                body: AnyEncodable(request)
            )
            return try await client.send(apiRequest)
        }
    }
    
    public var auth: Auth {
        Auth(client: self)
    }
}
