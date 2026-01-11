import Foundation

@available(macOS 12.0, *)
extension OpenCodeClient {
    public struct Project {
        let client: OpenCodeClient
        
        public func list(directory: String? = nil) async throws -> [opencode_sdk_swift.Project] {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<[opencode_sdk_swift.Project]>(
                method: .get,
                path: "/project",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
        
        public func current(directory: String? = nil) async throws -> opencode_sdk_swift.Project {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<opencode_sdk_swift.Project>(
                method: .get,
                path: "/project/current",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
        
        public func update(projectID: String, directory: String? = nil, request: ProjectUpdateRequest) async throws -> opencode_sdk_swift.Project {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let apiRequest = OpenCodeRequest<opencode_sdk_swift.Project>(
                method: .patch,
                path: "/project/\(projectID)",
                queryItems: queryItems,
                body: AnyEncodable(request)
            )
            return try await client.send(apiRequest)
        }
    }
    
    public var project: Project {
        Project(client: self)
    }
}
