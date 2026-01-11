import Foundation

public struct PartTime: Codable, Sendable {
    public let start: Int64
    public let end: Int64?
    
    public init(start: Int64, end: Int64? = nil) {
        self.start = start
        self.end = end
    }
}

public struct TextPart: Codable, Sendable {
    public let id: String
    public let sessionID: String
    public let messageID: String
    public let type: String
    public let text: String
    public let synthetic: Bool?
    public let ignored: Bool?
    public let time: PartTime?
    public let metadata: [String: AnyCodable]?
    
    public init(id: String, sessionID: String, messageID: String, type: String, text: String, synthetic: Bool? = nil, ignored: Bool? = nil, time: PartTime? = nil, metadata: [String: AnyCodable]? = nil) {
        self.id = id
        self.sessionID = sessionID
        self.messageID = messageID
        self.type = type
        self.text = text
        self.synthetic = synthetic
        self.ignored = ignored
        self.time = time
        self.metadata = metadata
    }

}



public struct SubtaskPart: Codable, Sendable {
    public let id: String
    public let sessionID: String
    public let messageID: String
    public let type: String
    public let prompt: String
    public let description: String
    public let agent: String
    public let command: String?
    
    public init(id: String, sessionID: String, messageID: String, type: String, prompt: String, description: String, agent: String, command: String? = nil) {
        self.id = id
        self.sessionID = sessionID
        self.messageID = messageID
        self.type = type
        self.prompt = prompt
        self.description = description
        self.agent = agent
        self.command = command
    }

}



public struct ReasoningPart: Codable, Sendable {
    public let id: String
    public let sessionID: String
    public let messageID: String
    public let type: String
    public let text: String
    public let metadata: [String: AnyCodable]?
    public let time: PartTime
    
    public init(id: String, sessionID: String, messageID: String, type: String, text: String, metadata: [String: AnyCodable]? = nil, time: PartTime) {
        self.id = id
        self.sessionID = sessionID
        self.messageID = messageID
        self.type = type
        self.text = text
        self.metadata = metadata
        self.time = time
    }

}



public struct FilePart: Codable, Sendable {
    public let id: String
    public let sessionID: String
    public let messageID: String
    public let type: String
    public let mime: String
    public let filename: String
    public let url: String
    public let source: FilePartSource?
    
    public init(id: String, sessionID: String, messageID: String, type: String, mime: String, filename: String, url: String, source: FilePartSource? = nil) {
        self.id = id
        self.sessionID = sessionID
        self.messageID = messageID
        self.type = type
        self.mime = mime
        self.filename = filename
        self.url = url
        self.source = source
    }

}



public struct ToolPart: Codable, Sendable {
    public let id: String
    public let sessionID: String
    public let messageID: String
    public let type: String
    public let callID: String
    public let tool: String
    public let state: ToolState
    public let metadata: [String: AnyCodable]?
    
    public init(id: String, sessionID: String, messageID: String, type: String, callID: String, tool: String, state: ToolState, metadata: [String: AnyCodable]? = nil) {
        self.id = id
        self.sessionID = sessionID
        self.messageID = messageID
        self.type = type
        self.callID = callID
        self.tool = tool
        self.state = state
        self.metadata = metadata
    }

}



public struct StepStartPart: Codable, Sendable {
    public let id: String
    public let sessionID: String
    public let messageID: String
    public let type: String
    public let snapshot: String?
    
    public init(id: String, sessionID: String, messageID: String, type: String, snapshot: String? = nil) {
        self.id = id
        self.sessionID = sessionID
        self.messageID = messageID
        self.type = type
        self.snapshot = snapshot
    }

}



public struct StepFinishPart: Codable, Sendable {
    public let id: String
    public let sessionID: String
    public let messageID: String
    public let type: String
    public let reason: String
    public let snapshot: String?
    public let cost: Double
    public let tokens: TokenUsage
    
    public init(id: String, sessionID: String, messageID: String, type: String, reason: String, snapshot: String? = nil, cost: Double, tokens: TokenUsage) {
        self.id = id
        self.sessionID = sessionID
        self.messageID = messageID
        self.type = type
        self.reason = reason
        self.snapshot = snapshot
        self.cost = cost
        self.tokens = tokens
    }

}



public struct SnapshotPart: Codable, Sendable {
    public let id: String
    public let sessionID: String
    public let messageID: String
    public let type: String
    public let snapshot: String
    
    public init(id: String, sessionID: String, messageID: String, type: String, snapshot: String) {
        self.id = id
        self.sessionID = sessionID
        self.messageID = messageID
        self.type = type
        self.snapshot = snapshot
    }

}



public struct PatchPart: Codable, Sendable {
    public let id: String
    public let sessionID: String
    public let messageID: String
    public let type: String
    public let hash: String
    public let files: [String]
    
    public init(id: String, sessionID: String, messageID: String, type: String, hash: String, files: [String]) {
        self.id = id
        self.sessionID = sessionID
        self.messageID = messageID
        self.type = type
        self.hash = hash
        self.files = files
    }

}



public struct AgentPartSource: Codable, Sendable {
    public let value: String
    public let start: Int64
    public let end: Int64
    
    public init(value: String, start: Int64, end: Int64) {
        self.value = value
        self.start = start
        self.end = end
    }
}

public struct AgentPart: Codable, Sendable {
    public let id: String
    public let sessionID: String
    public let messageID: String
    public let type: String
    public let name: String
    public let source: AgentPartSource
    
    public init(id: String, sessionID: String, messageID: String, type: String, name: String, source: AgentPartSource) {
        self.id = id
        self.sessionID = sessionID
        self.messageID = messageID
        self.type = type
        self.name = name
        self.source = source
    }
}



public struct RetryPart: Codable, Sendable {
    public let id: String
    public let sessionID: String
    public let messageID: String
    public let type: String
    public let attempt: Int
    public let error: APIError
    public let time: MessageTime
    
    public init(id: String, sessionID: String, messageID: String, type: String, attempt: Int, error: APIError, time: MessageTime) {
        self.id = id
        self.sessionID = sessionID
        self.messageID = messageID
        self.type = type
        self.attempt = attempt
        self.error = error
        self.time = time
    }

}



public struct CompactionPart: Codable, Sendable {
    public let id: String
    public let sessionID: String
    public let messageID: String
    public let type: String
    public let auto: Bool
    
    public init(id: String, sessionID: String, messageID: String, type: String, auto: Bool) {
        self.id = id
        self.sessionID = sessionID
        self.messageID = messageID
        self.type = type
        self.auto = auto
    }

}



public enum Part: Codable, Sendable {
    case text(TextPart)
    case subtask(SubtaskPart)
    case reasoning(ReasoningPart)
    case file(FilePart)
    case tool(ToolPart)
    case stepStart(StepStartPart)
    case stepFinish(StepFinishPart)
    case snapshot(SnapshotPart)
    case patch(PatchPart)
    case agent(AgentPart)
    case retry(RetryPart)
    case compaction(CompactionPart)
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        
        switch type {
        case "text":
            self = .text(try TextPart(from: decoder))
        case "subtask":
            self = .subtask(try SubtaskPart(from: decoder))
        case "reasoning":
            self = .reasoning(try ReasoningPart(from: decoder))
        case "file":
            self = .file(try FilePart(from: decoder))
        case "tool":
            self = .tool(try ToolPart(from: decoder))
        case "step-start":
            self = .stepStart(try StepStartPart(from: decoder))
        case "step-finish":
            self = .stepFinish(try StepFinishPart(from: decoder))
        case "snapshot":
            self = .snapshot(try SnapshotPart(from: decoder))
        case "patch":
            self = .patch(try PatchPart(from: decoder))
        case "agent":
            self = .agent(try AgentPart(from: decoder))
        case "retry":
            self = .retry(try RetryPart(from: decoder))
        case "compaction":
            self = .compaction(try CompactionPart(from: decoder))
        default:
            throw DecodingError.dataCorruptedError(forKey: .type, in: container, debugDescription: "Unknown part type: \(type)")
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        switch self {
        case .text(let part):
            try part.encode(to: encoder)
        case .subtask(let part):
            try part.encode(to: encoder)
        case .reasoning(let part):
            try part.encode(to: encoder)
        case .file(let part):
            try part.encode(to: encoder)
        case .tool(let part):
            try part.encode(to: encoder)
        case .stepStart(let part):
            try part.encode(to: encoder)
        case .stepFinish(let part):
            try part.encode(to: encoder)
        case .snapshot(let part):
            try part.encode(to: encoder)
        case .patch(let part):
            try part.encode(to: encoder)
        case .agent(let part):
            try part.encode(to: encoder)
        case .retry(let part):
            try part.encode(to: encoder)
        case .compaction(let part):
            try part.encode(to: encoder)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case type
    }
}

public enum FilePartSource: Codable, Sendable {
    case file(FileSource)
    case symbol(SymbolSource)
    case resource(ResourceSource)
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        
        switch type {
        case "file":
            self = .file(try FileSource(from: decoder))
        case "symbol":
            self = .symbol(try SymbolSource(from: decoder))
        case "resource":
            self = .resource(try ResourceSource(from: decoder))
        default:
            throw DecodingError.dataCorruptedError(forKey: .type, in: container, debugDescription: "Unknown source type: \(type)")
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        switch self {
        case .file(let source):
            try source.encode(to: encoder)
        case .symbol(let source):
            try source.encode(to: encoder)
        case .resource(let source):
            try source.encode(to: encoder)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case type
    }
}

public struct FileSource: Codable, Sendable {
    public let text: FilePartSourceText
    public let type: String
    public let path: String
    
    public init(text: FilePartSourceText, type: String, path: String) {
        self.text = text
        self.type = type
        self.path = path
    }

}

public struct SymbolSource: Codable, Sendable {
    public let text: FilePartSourceText
    public let type: String
    public let path: String
    public let range: Range
    public let name: String
    public let kind: Int
    
    public init(text: FilePartSourceText, type: String, path: String, range: Range, name: String, kind: Int) {
        self.text = text
        self.type = type
        self.path = path
        self.range = range
        self.name = name
        self.kind = kind
    }

}

public struct ResourceSource: Codable, Sendable {
    public let text: FilePartSourceText
    public let type: String
    public let clientName: String
    public let uri: String
    
    public init(text: FilePartSourceText, type: String, clientName: String, uri: String) {
        self.text = text
        self.type = type
        self.clientName = clientName
        self.uri = uri
    }

}

public struct FilePartSourceText: Codable, Sendable {
    public let value: String
    public let start: Int64
    public let end: Int64
    
    public init(value: String, start: Int64, end: Int64) {
        self.value = value
        self.start = start
        self.end = end
    }

}

public struct Range: Codable, Sendable {
    public let start: Position
    public let end: Position
    
    public init(start: Position, end: Position) {
        self.start = start
        self.end = end
    }

}

public struct Position: Codable, Sendable {
    public let line: Int
    public let character: Int
    
    public init(line: Int, character: Int) {
        self.line = line
        self.character = character
    }

}

public enum ToolState: Codable, Sendable {
    case pending(ToolStatePending)
    case running(ToolStateRunning)
    case completed(ToolStateCompleted)
    case error(ToolStateError)
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let status = try container.decode(String.self, forKey: .status)
        
        switch status {
        case "pending":
            self = .pending(try ToolStatePending(from: decoder))
        case "running":
            self = .running(try ToolStateRunning(from: decoder))
        case "completed":
            self = .completed(try ToolStateCompleted(from: decoder))
        case "error":
            self = .error(try ToolStateError(from: decoder))
        default:
            throw DecodingError.dataCorruptedError(forKey: .status, in: container, debugDescription: "Unknown tool state: \(status)")
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        switch self {
        case .pending(let state):
            try state.encode(to: encoder)
        case .running(let state):
            try state.encode(to: encoder)
        case .completed(let state):
            try state.encode(to: encoder)
        case .error(let state):
            try state.encode(to: encoder)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case status
    }
}

public struct ToolStatePending: Codable, Sendable {
    public let status: String
    public let input: [String: AnyCodable]
    public let raw: String
    
    public init(status: String, input: [String: AnyCodable], raw: String) {
        self.status = status
        self.input = input
        self.raw = raw
    }

}

public struct ToolStateRunning: Codable, Sendable {
    public let status: String
    public let input: [String: AnyCodable]
    public let title: String?
    public let metadata: [String: AnyCodable]?
    public let time: ToolTime
    
    public init(status: String, input: [String: AnyCodable], title: String? = nil, metadata: [String: AnyCodable]? = nil, time: ToolTime) {
        self.status = status
        self.input = input
        self.title = title
        self.metadata = metadata
        self.time = time
    }

}

public struct ToolStateCompleted: Codable, Sendable {
    public let status: String
    public let input: [String: AnyCodable]
    public let output: String
    public let title: String?
    public let metadata: [String: AnyCodable]?
    public let time: ToolTimeCompleted
    public let attachments: [FilePart]?
    
    public init(status: String, input: [String: AnyCodable], output: String, title: String? = nil, metadata: [String: AnyCodable]? = nil, time: ToolTimeCompleted, attachments: [FilePart]? = nil) {
        self.status = status
        self.input = input
        self.output = output
        self.title = title
        self.metadata = metadata
        self.time = time
        self.attachments = attachments
    }

}

public struct ToolStateError: Codable, Sendable {
    public let status: String
    public let input: [String: AnyCodable]
    public let error: String
    public let metadata: [String: AnyCodable]?
    public let time: ToolTime
    
    public init(status: String, input: [String: AnyCodable], error: String, metadata: [String: AnyCodable]? = nil, time: ToolTime) {
        self.status = status
        self.input = input
        self.error = error
        self.metadata = metadata
        self.time = time
    }

}

public struct ToolTime: Codable, Sendable {
    public let start: Int64
    
    public init(start: Int64) {
        self.start = start
    }

}

public struct ToolTimeCompleted: Codable, Sendable {
    public let start: Int64
    public let end: Int64
    public let compacted: Int64?
    
    public init(start: Int64, end: Int64, compacted: Int64? = nil) {
        self.start = start
        self.end = end
        self.compacted = compacted
    }

}