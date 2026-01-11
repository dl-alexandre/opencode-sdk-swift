import Foundation

public enum PartInput: Codable, Sendable {
    case text(TextPartInput)
    case file(FilePartInput)
    case agent(AgentPartInput)
    case subtask(SubtaskPartInput)
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        
        switch type {
        case "text":
            self = .text(try TextPartInput(from: decoder))
        case "file":
            self = .file(try FilePartInput(from: decoder))
        case "agent":
            self = .agent(try AgentPartInput(from: decoder))
        case "subtask":
            self = .subtask(try SubtaskPartInput(from: decoder))
        default:
            throw DecodingError.dataCorruptedError(forKey: .type, in: container, debugDescription: "Unknown part input type: \(type)")
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        switch self {
        case .text(let part):
            try part.encode(to: encoder)
        case .file(let part):
            try part.encode(to: encoder)
        case .agent(let part):
            try part.encode(to: encoder)
        case .subtask(let part):
            try part.encode(to: encoder)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case type
    }
}

public struct TextPartInput: Codable, Sendable {
    public let id: String?
    public let type: String
    public let text: String
    public let synthetic: Bool?
    public let ignored: Bool?
    public let time: PartTime?
    public let metadata: [String: AnyCodable]?
    
    public init(id: String? = nil, type: String = "text", text: String, synthetic: Bool? = nil, ignored: Bool? = nil, time: PartTime? = nil, metadata: [String: AnyCodable]? = nil) {
        self.id = id
        self.type = type
        self.text = text
        self.synthetic = synthetic
        self.ignored = ignored
        self.time = time
        self.metadata = metadata
    }

}

public struct FilePartInput: Codable, Sendable {
    public let id: String?
    public let type: String
    public let mime: String
    public let filename: String
    public let url: String
    public let source: FilePartSource?
    
    public init(id: String? = nil, type: String = "file", mime: String, filename: String, url: String, source: FilePartSource? = nil) {
        self.id = id
        self.type = type
        self.mime = mime
        self.filename = filename
        self.url = url
        self.source = source
    }

}

public struct AgentPartInput: Codable, Sendable {
    public let id: String?
    public let type: String
    public let name: String
    public let source: AgentPartSource
    
    public init(id: String? = nil, type: String = "agent", name: String, source: AgentPartSource) {
        self.id = id
        self.type = type
        self.name = name
        self.source = source
    }

}

public struct SubtaskPartInput: Codable, Sendable {
    public let id: String?
    public let type: String
    public let prompt: String
    public let description: String
    public let agent: String
    public let command: String?
    
    public init(id: String? = nil, type: String = "subtask", prompt: String, description: String, agent: String, command: String? = nil) {
        self.id = id
        self.type = type
        self.prompt = prompt
        self.description = description
        self.agent = agent
        self.command = command
    }

}