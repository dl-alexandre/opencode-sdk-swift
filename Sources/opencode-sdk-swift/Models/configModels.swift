import Foundation

public struct Config: Codable, Sendable {
    public let theme: String?
    public let logLevel: String?
    public let model: String?
    public let defaultAgent: String?
    
    public init(theme: String? = nil, logLevel: String? = nil, model: String? = nil, defaultAgent: String? = nil) {
        self.theme = theme
        self.logLevel = logLevel
        self.model = model
        self.defaultAgent = defaultAgent
    }

}

public struct ToolIDs: Codable, Sendable {
    public let toolIDs: [String]
    
    public init(toolIDs: [String]) {
        self.toolIDs = toolIDs
    }

}

public struct ToolListItem: Codable, Sendable {
    public let id: String
    public let description: String
    public let parameters: [String: AnyCodable]
    
    public init(id: String, description: String, parameters: [String: AnyCodable]) {
        self.id = id
        self.description = description
        self.parameters = parameters
    }

}

public enum AnyCodable: Codable, Sendable {
    case string(String)
    case int(Int)
    case double(Double)
    case bool(Bool)
    case array([AnyCodable])
    case dictionary([String: AnyCodable])
    case null
    
    public var value: Any {
        switch self {
        case .string(let v): return v
        case .int(let v): return v
        case .double(let v): return v
        case .bool(let v): return v
        case .array(let v): return v.map { $0.value }
        case .dictionary(let v): return v.mapValues { $0.value }
        case .null: return NSNull()
        }
    }
    
    public init(_ value: Any) {
        switch value {
        case let string as String:
            self = .string(string)
        case let int as Int:
            self = .int(int)
        case let double as Double:
            self = .double(double)
        case let bool as Bool:
            self = .bool(bool)
        case let array as [Any]:
            self = .array(array.map { AnyCodable($0) })
        case let dictionary as [String: Any]:
            self = .dictionary(dictionary.mapValues { AnyCodable($0) })
        case is NSNull:
            self = .null
        default:
            self = .null
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if container.decodeNil() {
            self = .null
        } else if let bool = try? container.decode(Bool.self) {
            self = .bool(bool)
        } else if let int = try? container.decode(Int.self) {
            self = .int(int)
        } else if let double = try? container.decode(Double.self) {
            self = .double(double)
        } else if let string = try? container.decode(String.self) {
            self = .string(string)
        } else if let array = try? container.decode([AnyCodable].self) {
            self = .array(array)
        } else if let dictionary = try? container.decode([String: AnyCodable].self) {
            self = .dictionary(dictionary)
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "AnyCodable value cannot be decoded")
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let value):
            try container.encode(value)
        case .int(let value):
            try container.encode(value)
        case .double(let value):
            try container.encode(value)
        case .bool(let value):
            try container.encode(value)
        case .array(let value):
            try container.encode(value)
        case .dictionary(let value):
            try container.encode(value)
        case .null:
            try container.encodeNil()
        }
    }
}