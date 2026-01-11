import Foundation

@available(macOS 12.0, *)
extension OpenCodeClient {
    public struct Question {
        let client: OpenCodeClient
        
        public func list(directory: String? = nil) async throws -> [QuestionRequest] {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<[QuestionRequest]>(
                method: .get,
                path: "/question",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
        
        public func reply(requestID: String, directory: String? = nil, request: QuestionReplyRequest) async throws -> Bool {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let apiRequest = OpenCodeRequest<Bool>(
                method: .post,
                path: "/question/\(requestID)/reply",
                queryItems: queryItems,
                body: AnyEncodable(request)
            )
            return try await client.send(apiRequest)
        }
        
        public func reject(requestID: String, directory: String? = nil) async throws -> Bool {
            var queryItems: [URLQueryItem] = []
            if let directory = directory {
                queryItems.append(URLQueryItem(name: "directory", value: directory))
            }
            let request = OpenCodeRequest<Bool>(
                method: .post,
                path: "/question/\(requestID)/reject",
                queryItems: queryItems
            )
            return try await client.send(request)
        }
    }
    
    public var question: Question {
        Question(client: self)
    }
}
