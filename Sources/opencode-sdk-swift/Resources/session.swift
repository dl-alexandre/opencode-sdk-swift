import Foundation

@available(macOS 12.0, *)
extension OpenCodeClient {
    public struct Session {
        let client: OpenCodeClient
        
        public func list(directory: String? = nil, start: Int64? = nil, search: String? = nil, limit: Int? = nil) async throws -> [opencode_sdk_swift.Session] {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            if let start = start {
                queryItems.append(URLQueryItem(name: "start", value: String(start)))
            }
            if let search = search {
                queryItems.append(URLQueryItem(name: "search", value: search))
            }
            if let limit = limit {
                queryItems.append(URLQueryItem(name: "limit", value: String(limit)))
            }
            let request = OpenCodeRequest<[opencode_sdk_swift.Session]>(
                method: .get,
                path: "/session",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
        
        public func create(directory: String? = nil, request: SessionCreateRequest) async throws -> opencode_sdk_swift.Session {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let apiRequest = OpenCodeRequest<opencode_sdk_swift.Session>(
                method: .post,
                path: "/session",
                queryItems: queryItems,
                body: AnyEncodable(request)
            )
            return try await client.send(apiRequest)
        }
        
        public func status(directory: String? = nil) async throws -> [String: SessionStatus] {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<[String: SessionStatus]>(
                method: .get,
                path: "/session/status",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
        
        public func get(sessionID: String, directory: String? = nil) async throws -> opencode_sdk_swift.Session {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<opencode_sdk_swift.Session>(
                method: .get,
                path: "/session/\(sessionID)",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
        
        public func delete(sessionID: String, directory: String? = nil) async throws -> Bool {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<Bool>(
                method: .delete,
                path: "/session/\(sessionID)",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
        
        public func update(sessionID: String, directory: String? = nil, request: SessionUpdateRequest) async throws -> opencode_sdk_swift.Session {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let apiRequest = OpenCodeRequest<opencode_sdk_swift.Session>(
                method: .patch,
                path: "/session/\(sessionID)",
                queryItems: queryItems,
                body: AnyEncodable(request)
            )
            return try await client.send(apiRequest)
        }
        
        public func children(sessionID: String, directory: String? = nil) async throws -> [opencode_sdk_swift.Session] {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<[opencode_sdk_swift.Session]>(
                method: .get,
                path: "/session/\(sessionID)/children",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
        
        public func todo(sessionID: String, directory: String? = nil) async throws -> [Todo] {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<[Todo]>(
                method: .get,
                path: "/session/\(sessionID)/todo",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
        
        public func initialize(sessionID: String, directory: String? = nil, request: SessionInitRequest) async throws -> Bool {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let apiRequest = OpenCodeRequest<Bool>(
                method: .post,
                path: "/session/\(sessionID)/init",
                queryItems: queryItems,
                body: AnyEncodable(request)
            )
            return try await client.send(apiRequest)
        }
        
        public func fork(sessionID: String, directory: String? = nil, request: SessionForkRequest) async throws -> opencode_sdk_swift.Session {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let apiRequest = OpenCodeRequest<opencode_sdk_swift.Session>(
                method: .post,
                path: "/session/\(sessionID)/fork",
                queryItems: queryItems,
                body: AnyEncodable(request)
            )
            return try await client.send(apiRequest)
        }
        
        public func abort(sessionID: String, directory: String? = nil) async throws -> Bool {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<Bool>(
                method: .post,
                path: "/session/\(sessionID)/abort",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
        
        public func share(sessionID: String, directory: String? = nil) async throws -> opencode_sdk_swift.Session {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<opencode_sdk_swift.Session>(
                method: .post,
                path: "/session/\(sessionID)/share",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
        
        public func unshare(sessionID: String, directory: String? = nil) async throws -> opencode_sdk_swift.Session {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<opencode_sdk_swift.Session>(
                method: .delete,
                path: "/session/\(sessionID)/share",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
        
        public func diff(sessionID: String, directory: String? = nil, messageID: String? = nil) async throws -> [FileDiff] {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            if let messageID = messageID {
                queryItems.append(URLQueryItem(name: "messageID", value: messageID))
            }
            let request = OpenCodeRequest<[FileDiff]>(
                method: .get,
                path: "/session/\(sessionID)/diff",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
        
        public func summarize(sessionID: String, directory: String? = nil, request: SessionSummarizeRequest) async throws -> Bool {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let apiRequest = OpenCodeRequest<Bool>(
                method: .post,
                path: "/session/\(sessionID)/summarize",
                queryItems: queryItems,
                body: AnyEncodable(request)
            )
            return try await client.send(apiRequest)
        }
        
        public func messages(sessionID: String, directory: String? = nil, limit: Int? = nil) async throws -> [Message] {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            if let limit = limit {
                queryItems.append(URLQueryItem(name: "limit", value: String(limit)))
            }
            let request = OpenCodeRequest<[Message]>(
                method: .get,
                path: "/session/\(sessionID)/message",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
        
        public func prompt(sessionID: String, directory: String? = nil, request: SessionPromptRequest) async throws -> Message {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let apiRequest = OpenCodeRequest<Message>(
                method: .post,
                path: "/session/\(sessionID)/message",
                queryItems: queryItems,
                body: AnyEncodable(request)
            )
            return try await client.send(apiRequest)
        }
        
        public func promptAsync(sessionID: String, directory: String? = nil, request: SessionPromptRequest) async throws {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let apiRequest = OpenCodeRequest<EmptyResponse>(
                method: .post,
                path: "/session/\(sessionID)/prompt_async",
                queryItems: queryItems,
                body: AnyEncodable(request)
            )
            try await client.send(apiRequest)
        }
        
        public func message(sessionID: String, messageID: String, directory: String? = nil) async throws -> Message {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<Message>(
                method: .get,
                path: "/session/\(sessionID)/message/\(messageID)",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
        
        public func revert(sessionID: String, directory: String? = nil, request: SessionRevertRequest) async throws -> opencode_sdk_swift.Session {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let apiRequest = OpenCodeRequest<opencode_sdk_swift.Session>(
                method: .post,
                path: "/session/\(sessionID)/revert",
                queryItems: queryItems,
                body: AnyEncodable(request)
            )
            return try await client.send(apiRequest)
        }
        
        public func unrevert(sessionID: String, directory: String? = nil) async throws -> opencode_sdk_swift.Session {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<opencode_sdk_swift.Session>(
                method: .post,
                path: "/session/\(sessionID)/unrevert",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
        
        public func command(sessionID: String, directory: String? = nil, request: SessionCommandRequest) async throws -> Message {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let apiRequest = OpenCodeRequest<Message>(
                method: .post,
                path: "/session/\(sessionID)/command",
                queryItems: queryItems,
                body: AnyEncodable(request)
            )
            return try await client.send(apiRequest)
        }
        
        public func shell(sessionID: String, directory: String? = nil, request: SessionShellRequest) async throws -> AssistantMessage {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let apiRequest = OpenCodeRequest<AssistantMessage>(
                method: .post,
                path: "/session/\(sessionID)/shell",
                queryItems: queryItems,
                body: AnyEncodable(request)
            )
            return try await client.send(apiRequest)
        }
    }
    
    public var session: Session {
        Session(client: self)
    }
}
