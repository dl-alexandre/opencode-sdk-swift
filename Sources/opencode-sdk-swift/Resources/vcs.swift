import Foundation

@available(macOS 12.0, *)
extension OpenCodeClient {
    public struct Vcs {
        let client: OpenCodeClient
        
        public func get(directory: String? = nil) async throws -> VcsInfo {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<VcsInfo>(
                method: .get,
                path: "/vcs",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
    }
    
    public var vcs: Vcs {
        Vcs(client: self)
    }
}
