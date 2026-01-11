import Foundation

@available(macOS 12.0, *)
extension OpenCodeClient {
    public struct Command {
        let client: OpenCodeClient
        
        public func list(directory: String? = nil) async throws -> [opencode_sdk_swift.Command] {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<[opencode_sdk_swift.Command]>(
                method: .get,
                path: "/command",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
    }
    
    public var command: Command {
        Command(client: self)
    }
}
