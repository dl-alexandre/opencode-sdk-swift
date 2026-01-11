import Foundation

public struct Message: Codable, Sendable {
    public let info: MessageInfo
    public let parts: [Part]
    
    public init(info: MessageInfo, parts: [Part]) {
        self.info = info
        self.parts = parts
    }

}

public enum MessageInfo: Codable, Sendable {
    case user(UserMessage)
    case assistant(AssistantMessage)
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let user = try? container.decode(UserMessage.self) {
            self = .user(user)
        } else {
            self = .assistant(try container.decode(AssistantMessage.self))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .user(let value):
            try container.encode(value)
        case .assistant(let value):
            try container.encode(value)
        }
    }
}

public struct UserMessage: Codable, Sendable {
    public let id: String
    public let sessionID: String
    public let role: String
    public let time: MessageTime
    public let summary: MessageSummary?
    public let agent: String
    public let model: ModelInfo
    public let system: String?
    public let tools: [String: Bool]?
    public let variant: String?
    
    public init(id: String, sessionID: String, role: String, time: MessageTime, summary: MessageSummary? = nil, agent: String, model: ModelInfo, system: String? = nil, tools: [String: Bool]? = nil, variant: String? = nil) {
        self.id = id
        self.sessionID = sessionID
        self.role = role
        self.time = time
        self.summary = summary
        self.agent = agent
        self.model = model
        self.system = system
        self.tools = tools
        self.variant = variant
    }

}

public struct AssistantMessage: Codable, Sendable {
    public let id: String
    public let sessionID: String
    public let role: String
    public let time: AssistantMessageTime
    public let error: APIError?
    public let parentID: String
    public let modelID: String
    public let providerID: String
    public let mode: String
    public let agent: String
    public let path: MessagePath
    public let summary: Bool?
    public let cost: Double
    public let tokens: TokenUsage
    public let finish: String?
    
    public init(id: String, sessionID: String, role: String, time: AssistantMessageTime, error: APIError? = nil, parentID: String, modelID: String, providerID: String, mode: String, agent: String, path: MessagePath, summary: Bool? = nil, cost: Double, tokens: TokenUsage, finish: String? = nil) {
        self.id = id
        self.sessionID = sessionID
        self.role = role
        self.time = time
        self.error = error
        self.parentID = parentID
        self.modelID = modelID
        self.providerID = providerID
        self.mode = mode
        self.agent = agent
        self.path = path
        self.summary = summary
        self.cost = cost
        self.tokens = tokens
        self.finish = finish
    }

}

public struct MessageTime: Codable, Sendable {
    public let created: Int64
    
    public init(created: Int64) {
        self.created = created
    }

}

public struct AssistantMessageTime: Codable, Sendable {
    public let created: Int64
    public let completed: Int64?
    
    public init(created: Int64, completed: Int64? = nil) {
        self.created = created
        self.completed = completed
    }

}

public struct MessageSummary: Codable, Sendable {
    public let title: String
    public let body: String
    public let diffs: [opencode_sdk_swift.FileDiff]
    
    public init(title: String, body: String, diffs: [opencode_sdk_swift.FileDiff]) {
        self.title = title
        self.body = body
        self.diffs = diffs
    }

}

public struct ModelInfo: Codable, Sendable {
    public let providerID: String
    public let modelID: String
    
    public init(providerID: String, modelID: String) {
        self.providerID = providerID
        self.modelID = modelID
    }

}

public struct MessagePath: Codable, Sendable {
    public let cwd: String
    public let root: String
    
    public init(cwd: String, root: String) {
        self.cwd = cwd
        self.root = root
    }

}

public struct TokenUsage: Codable, Sendable {
    public let input: Int
    public let output: Int
    public let reasoning: Int
    public let cache: CacheUsage
    
    public init(input: Int, output: Int, reasoning: Int, cache: CacheUsage) {
        self.input = input
        self.output = output
        self.reasoning = reasoning
        self.cache = cache
    }

}

public struct CacheUsage: Codable, Sendable {
    public let read: Int
    public let write: Int
    
    public init(read: Int, write: Int) {
        self.read = read
        self.write = write
    }

}

public struct APIError: Codable, Sendable {
    public let name: String
    public let data: APIErrorData
    
    public init(name: String, data: APIErrorData) {
        self.name = name
        self.data = data
    }

}

public struct APIErrorData: Codable, Sendable {
    public let message: String
    public let statusCode: Int?
    public let isRetryable: Bool
    public let responseHeaders: [String: String]?
    public let responseBody: String?
    public let metadata: [String: String]?
    
    public init(message: String, statusCode: Int? = nil, isRetryable: Bool, responseHeaders: [String: String]? = nil, responseBody: String? = nil, metadata: [String: String]? = nil) {
        self.message = message
        self.statusCode = statusCode
        self.isRetryable = isRetryable
        self.responseHeaders = responseHeaders
        self.responseBody = responseBody
        self.metadata = metadata
    }

}