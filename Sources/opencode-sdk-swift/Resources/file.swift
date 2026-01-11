import Foundation

@available(macOS 12.0, *)
extension OpenCodeClient {
    public struct File {
        let client: OpenCodeClient
        
        public func list(path: String, directory: String? = nil) async throws -> [FileNode] {
            var queryItems: [URLQueryItem] = []
            queryItems.append(URLQueryItem(name: "path", value: path))
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<[FileNode]>(
                method: .get,
                path: "/file",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
        
        public func read(path: String, directory: String? = nil) async throws -> FileContent {
            var queryItems: [URLQueryItem] = []
            queryItems.append(URLQueryItem(name: "path", value: path))
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<FileContent>(
                method: .get,
                path: "/file/content",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
        
        public func status(directory: String? = nil) async throws -> [opencode_sdk_swift.File] {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<[opencode_sdk_swift.File]>(
                method: .get,
                path: "/file/status",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
    }
    
    public var file: File {
        File(client: self)
    }
}
