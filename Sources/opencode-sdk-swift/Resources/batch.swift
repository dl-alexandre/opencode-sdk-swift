import Foundation

@available(macOS 12.0, *)
extension OpenCodeClient {
    public struct Batch: Sendable {
        let client: OpenCodeClient
        
        public func fetchSessionData(
            sessionID: String,
            directory: String? = nil
        ) async throws -> (opencode_sdk_swift.Session, [Message], [Todo]) {
            let clientRef = client
            var sessionQueryItems: [URLQueryItem] = []
            var messagesQueryItems: [URLQueryItem] = []
            var todosQueryItems: [URLQueryItem] = []
            
            if let directory = directory {
                sessionQueryItems.append(URLQueryItem(name: "directory", value: directory))
                messagesQueryItems.append(URLQueryItem(name: "directory", value: directory))
                todosQueryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            
            async let session = clientRef.send(OpenCodeRequest<opencode_sdk_swift.Session>(
                method: .get,
                path: "/session/\(sessionID)",
                queryItems: sessionQueryItems
            ))
            async let messages = clientRef.send(OpenCodeRequest<[Message]>(
                method: .get,
                path: "/session/\(sessionID)/message",
                queryItems: messagesQueryItems
            ))
            async let todos = clientRef.send(OpenCodeRequest<[Todo]>(
                method: .get,
                path: "/session/\(sessionID)/todo",
                queryItems: todosQueryItems
            ))
            
            return try await (session, messages, todos)
        }
        
        public func fetchProjectData(
            directory: String? = nil
        ) async throws -> (opencode_sdk_swift.Project, [opencode_sdk_swift.Session], opencode_sdk_swift.Config) {
            let clientRef = client
            var projectQueryItems: [URLQueryItem] = []
            var sessionsQueryItems: [URLQueryItem] = []
            var configQueryItems: [URLQueryItem] = []
            
            if let directory = directory {
                projectQueryItems.append(URLQueryItem(name: "directory", value: directory))
                sessionsQueryItems.append(URLQueryItem(name: "directory", value: directory))
                configQueryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            
            async let project = clientRef.send(OpenCodeRequest<opencode_sdk_swift.Project>(
                method: .get,
                path: "/project/current",
                queryItems: projectQueryItems
            ))
            async let sessions = clientRef.send(OpenCodeRequest<[opencode_sdk_swift.Session]>(
                method: .get,
                path: "/session",
                queryItems: sessionsQueryItems
            ))
            async let config = clientRef.send(OpenCodeRequest<opencode_sdk_swift.Config>(
                method: .get,
                path: "/config",
                queryItems: configQueryItems
            ))
            
            return try await (project, sessions, config)
        }
        
        public func fetchProviderData(
            directory: String? = nil
        ) async throws -> (ProviderListResponse, [String: [ProviderAuthMethod]]) {
            let clientRef = client
            var providersQueryItems: [URLQueryItem] = []
            var authQueryItems: [URLQueryItem] = []
            
            if let directory = directory {
                providersQueryItems.append(URLQueryItem(name: "directory", value: directory))
                authQueryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            
            async let providers = clientRef.send(OpenCodeRequest<ProviderListResponse>(
                method: .get,
                path: "/provider",
                queryItems: providersQueryItems
            ))
            async let authMethods = clientRef.send(OpenCodeRequest<[String: [ProviderAuthMethod]]>(
                method: .get,
                path: "/provider/auth",
                queryItems: authQueryItems
            ))
            
            return try await (providers, authMethods)
        }
    }
    
    public var batch: Batch {
        Batch(client: self)
    }
}
