import Foundation

@available(macOS 12.0, *)
extension OpenCodeClient {
    public struct Instance {
        let client: OpenCodeClient
        
        public func dispose(directory: String? = nil) async throws -> Bool {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<Bool>(
                method: .post,
                path: "/instance/dispose",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
    }
    
    public var instance: Instance {
        Instance(client: self)
    }
}
