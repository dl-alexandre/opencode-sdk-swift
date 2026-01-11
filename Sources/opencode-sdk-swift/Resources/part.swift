import Foundation

@available(macOS 12.0, *)
extension OpenCodeClient {
    public struct Part {
        let client: OpenCodeClient
        
        public func update(sessionID: String, messageID: String, partID: String, directory: String? = nil, request: opencode_sdk_swift.Part) async throws -> opencode_sdk_swift.Part {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let apiRequest = OpenCodeRequest<opencode_sdk_swift.Part>(
                method: .patch,
                path: "/session/\(sessionID)/message/\(messageID)/part/\(partID)",
                queryItems: queryItems,
                body: AnyEncodable(request)
            )
            return try await client.send(apiRequest)
        }
        
        public func delete(sessionID: String, messageID: String, partID: String, directory: String? = nil) async throws -> Bool {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<Bool>(
                method: .delete,
                path: "/session/\(sessionID)/message/\(messageID)/part/\(partID)",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
    }
    
    public var part: Part {
        Part(client: self)
    }
}
