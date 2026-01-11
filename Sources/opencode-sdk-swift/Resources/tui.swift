import Foundation

@available(macOS 12.0, *)
extension OpenCodeClient {
    public struct Tui {
        let client: OpenCodeClient
        
        public func appendPrompt(directory: String? = nil, request: TuiAppendPromptRequest) async throws -> Bool {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let apiRequest = OpenCodeRequest<Bool>(
                method: .post,
                path: "/tui/append-prompt",
                queryItems: queryItems,
                body: AnyEncodable(request)
            )
            return try await client.send(apiRequest)
        }
        
        public func openHelp(directory: String? = nil) async throws -> Bool {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<Bool>(
                method: .post,
                path: "/tui/open-help",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
        
        public func openSessions(directory: String? = nil) async throws -> Bool {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<Bool>(
                method: .post,
                path: "/tui/open-sessions",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
        
        public func openThemes(directory: String? = nil) async throws -> Bool {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<Bool>(
                method: .post,
                path: "/tui/open-themes",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
        
        public func openModels(directory: String? = nil) async throws -> Bool {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<Bool>(
                method: .post,
                path: "/tui/open-models",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
        
        public func submitPrompt(directory: String? = nil) async throws -> Bool {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<Bool>(
                method: .post,
                path: "/tui/submit-prompt",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
        
        public func clearPrompt(directory: String? = nil) async throws -> Bool {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<Bool>(
                method: .post,
                path: "/tui/clear-prompt",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
        
        public func executeCommand(directory: String? = nil, request: TuiExecuteCommandRequest) async throws -> Bool {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let apiRequest = OpenCodeRequest<Bool>(
                method: .post,
                path: "/tui/execute-command",
                queryItems: queryItems,
                body: AnyEncodable(request)
            )
            return try await client.send(apiRequest)
        }
        
        public func showToast(directory: String? = nil, request: TuiShowToastRequest) async throws -> Bool {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let apiRequest = OpenCodeRequest<Bool>(
                method: .post,
                path: "/tui/show-toast",
                queryItems: queryItems,
                body: AnyEncodable(request)
            )
            return try await client.send(apiRequest)
        }
        
        public func selectSession(directory: String? = nil, request: TuiSelectSessionRequest) async throws -> Bool {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let apiRequest = OpenCodeRequest<Bool>(
                method: .post,
                path: "/tui/select-session",
                queryItems: queryItems,
                body: AnyEncodable(request)
            )
            return try await client.send(apiRequest)
        }
        
        public func controlNext(directory: String? = nil) async throws -> [String: AnyCodable] {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<[String: AnyCodable]>(
                method: .get,
                path: "/tui/control/next",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
        
        public func controlResponse(directory: String? = nil, body: [String: AnyCodable] = [:]) async throws -> Bool {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let apiRequest = OpenCodeRequest<Bool>(
                method: .post,
                path: "/tui/control/response",
                queryItems: queryItems,
                body: AnyEncodable(body)
            )
            return try await client.send(apiRequest)
        }
    }
    
    public var tui: Tui {
        Tui(client: self)
    }
}
