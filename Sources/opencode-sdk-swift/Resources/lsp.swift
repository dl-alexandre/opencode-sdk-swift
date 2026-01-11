import Foundation

@available(macOS 12.0, *)
extension OpenCodeClient {
    public struct LSP {
        let client: OpenCodeClient
        
        public func status(directory: String? = nil) async throws -> [LSPStatus] {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<[LSPStatus]>(
                method: .get,
                path: "/lsp",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
    }
    
    public var lsp: LSP {
        LSP(client: self)
    }
}
