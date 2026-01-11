import Foundation

@available(macOS 12.0, *)
extension OpenCodeClient {
    public struct App {
        let client: OpenCodeClient
        
        public func log(directory: String? = nil, request: AppLogRequest) async throws -> Bool {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let apiRequest = OpenCodeRequest<Bool>(
                method: .post,
                path: "/log",
                queryItems: queryItems,
                body: AnyEncodable(request)
            )
            return try await client.send(apiRequest)
        }
        
        public func agents(directory: String? = nil) async throws -> [Agent] {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<[Agent]>(
                method: .get,
                path: "/agent",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
    }
    
    public var app: App {
        App(client: self)
    }
}
