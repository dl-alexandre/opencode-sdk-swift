import Foundation

@available(macOS 12.0, *)
extension OpenCodeClient {
    public struct Formatter {
        let client: OpenCodeClient
        
        public func status(directory: String? = nil) async throws -> [FormatterStatus] {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<[FormatterStatus]>(
                method: .get,
                path: "/formatter",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
    }
    
    public var formatter: Formatter {
        Formatter(client: self)
    }
}
