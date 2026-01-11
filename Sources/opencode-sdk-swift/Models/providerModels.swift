import Foundation

public struct Provider: Codable, Sendable {
    public let id: String
    public let name: String
    public let source: String
    public let env: [String]
    public let key: String?
    public let options: [String: AnyCodable]
    public let models: [String: Model]
    
    public init(id: String, name: String, source: String, env: [String], key: String? = nil, options: [String: AnyCodable], models: [String: Model]) {
        self.id = id
        self.name = name
        self.source = source
        self.env = env
        self.key = key
        self.options = options
        self.models = models
    }

}

public struct Model: Codable, Sendable {
    public let id: String
    public let providerID: String
    public let api: ModelAPI
    public let name: String
    public let family: String
    public let capabilities: ModelCapabilities
    public let cost: ModelCost
    public let limit: ModelLimit
    public let status: String
    public let options: [String: AnyCodable]
    public let headers: [String: String]
    public let releaseDate: String
    public let variants: [String: [String: AnyCodable]]?
    
    public init(id: String, providerID: String, api: ModelAPI, name: String, family: String, capabilities: ModelCapabilities, cost: ModelCost, limit: ModelLimit, status: String, options: [String: AnyCodable], headers: [String: String], releaseDate: String, variants: [String: [String: AnyCodable]]? = nil) {
        self.id = id
        self.providerID = providerID
        self.api = api
        self.name = name
        self.family = family
        self.capabilities = capabilities
        self.cost = cost
        self.limit = limit
        self.status = status
        self.options = options
        self.headers = headers
        self.releaseDate = releaseDate
        self.variants = variants
    }
    
    enum CodingKeys: String, CodingKey {
        case id, providerID, api, name, family, capabilities, cost, limit, status, options, headers
        case releaseDate = "release_date"
        case variants
    }
}

public struct ModelAPI: Codable, Sendable {
    public let id: String
    public let url: String
    public let npm: String
    
    public init(id: String, url: String, npm: String) {
        self.id = id
        self.url = url
        self.npm = npm
    }

}

public struct ModelCapabilities: Codable, Sendable {
    public let temperature: Bool
    public let reasoning: Bool
    public let attachment: Bool
    public let toolcall: Bool
    public let input: ModelModalities
    public let output: ModelModalities
    public let interleaved: InterleavedCapability
    
    public init(temperature: Bool, reasoning: Bool, attachment: Bool, toolcall: Bool, input: ModelModalities, output: ModelModalities, interleaved: InterleavedCapability) {
        self.temperature = temperature
        self.reasoning = reasoning
        self.attachment = attachment
        self.toolcall = toolcall
        self.input = input
        self.output = output
        self.interleaved = interleaved
    }

}

public struct ModelModalities: Codable, Sendable {
    public let text: Bool
    public let audio: Bool
    public let image: Bool
    public let video: Bool
    public let pdf: Bool
    
    public init(text: Bool, audio: Bool, image: Bool, video: Bool, pdf: Bool) {
        self.text = text
        self.audio = audio
        self.image = image
        self.video = video
        self.pdf = pdf
    }

}

public enum InterleavedCapability: Codable, Sendable {
    case bool(Bool)
    case object(InterleavedObject)
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let bool = try? container.decode(Bool.self) {
            self = .bool(bool)
        } else {
            self = .object(try container.decode(InterleavedObject.self))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let value):
            try container.encode(value)
        case .object(let value):
            try container.encode(value)
        }
    }
}

public struct InterleavedObject: Codable, Sendable {
    public let field: String
    
    public init(field: String) {
        self.field = field
    }

}

public struct ModelCost: Codable, Sendable {
    public let input: Double
    public let output: Double
    public let cache: ModelCacheCost
    public let experimentalOver200K: ModelCostOver200K?
    
    public init(input: Double, output: Double, cache: ModelCacheCost, experimentalOver200K: ModelCostOver200K? = nil) {
        self.input = input
        self.output = output
        self.cache = cache
        self.experimentalOver200K = experimentalOver200K
    }

}

public struct ModelCacheCost: Codable, Sendable {
    public let read: Double
    public let write: Double
    
    public init(read: Double, write: Double) {
        self.read = read
        self.write = write
    }

}

public struct ModelCostOver200K: Codable, Sendable {
    public let input: Double
    public let output: Double
    public let cache: ModelCacheCost
    
    public init(input: Double, output: Double, cache: ModelCacheCost) {
        self.input = input
        self.output = output
        self.cache = cache
    }

}

public struct ModelLimit: Codable, Sendable {
    public let context: Int
    public let output: Int
    
    public init(context: Int, output: Int) {
        self.context = context
        self.output = output
    }

}

public struct ProviderListResponse: Codable, Sendable {
    public let all: [Provider]
    public let `default`: [String: String]
    public let connected: [String]
    
    public init(all: [Provider], default: [String: String], connected: [String]) {
        self.all = all
        self.`default` = `default`
        self.connected = connected
    }

}

public struct ProviderAuthMethod: Codable, Sendable {
    public let type: String
    public let label: String
    
    public init(type: String, label: String) {
        self.type = type
        self.label = label
    }

}

public struct ProviderAuthAuthorization: Codable, Sendable {
    public let url: String
    public let method: String
    public let instructions: String
    
    public init(url: String, method: String, instructions: String) {
        self.url = url
        self.method = method
        self.instructions = instructions
    }

}

public struct ProviderOAuthAuthorizeRequest: Codable, Sendable {
    public let method: Int
    
    public init(method: Int) {
        self.method = method
    }

}

public struct ProviderOAuthCallbackRequest: Codable, Sendable {
    public let method: Int
    public let code: String?
    
    public init(method: Int, code: String? = nil) {
        self.method = method
        self.code = code
    }

}