import Foundation

@available(macOS 12.0, *)
extension OpenCodeClient {
    public struct Provider {
        let client: OpenCodeClient
        
        public func list(directory: String? = nil) async throws -> ProviderListResponse {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<ProviderListResponse>(
                method: .get,
                path: "/provider",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
        
        public func auth(directory: String? = nil) async throws -> [String: [ProviderAuthMethod]] {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<[String: [ProviderAuthMethod]]>(
                method: .get,
                path: "/provider/auth",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
        
        public func oauthAuthorize(providerID: String, directory: String? = nil, request: ProviderOAuthAuthorizeRequest) async throws -> ProviderAuthAuthorization {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let apiRequest = OpenCodeRequest<ProviderAuthAuthorization>(
                method: .post,
                path: "/provider/\(providerID)/oauth/authorize",
                queryItems: queryItems,
                body: AnyEncodable(request)
            )
            return try await client.send(apiRequest)
        }
        
        public func oauthCallback(providerID: String, directory: String? = nil, request: ProviderOAuthCallbackRequest) async throws -> Bool {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let apiRequest = OpenCodeRequest<Bool>(
                method: .post,
                path: "/provider/\(providerID)/oauth/callback",
                queryItems: queryItems,
                body: AnyEncodable(request)
            )
            return try await client.send(apiRequest)
        }
    }
    
    public var provider: Provider {
        Provider(client: self)
    }
}
