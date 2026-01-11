import Foundation

public struct MCPStatus: Codable, Sendable {
    public let status: String
    public let error: String?
    
    public init(status: String, error: String? = nil) {
        self.status = status
        self.error = error
    }

}

public struct McpResource: Codable, Sendable {
    public let name: String
    public let uri: String
    public let description: String?
    public let mimeType: String?
    public let client: String
    
    public init(name: String, uri: String, description: String? = nil, mimeType: String? = nil, client: String) {
        self.name = name
        self.uri = uri
        self.description = description
        self.mimeType = mimeType
        self.client = client
    }

}

public enum McpConfig: Codable, Sendable {
    case local(McpLocalConfig)
    case remote(McpRemoteConfig)
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        
        switch type {
        case "local":
            self = .local(try McpLocalConfig(from: decoder))
        case "remote":
            self = .remote(try McpRemoteConfig(from: decoder))
        default:
            throw DecodingError.dataCorruptedError(forKey: .type, in: container, debugDescription: "Unknown MCP config type: \(type)")
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        switch self {
        case .local(let config):
            try config.encode(to: encoder)
        case .remote(let config):
            try config.encode(to: encoder)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case type
    }
}

public struct McpLocalConfig: Codable, Sendable {
    public let type: String
    public let command: [String]
    public let environment: [String: String]?
    public let enabled: Bool?
    public let timeout: Int?
    
    public init(type: String = "local", command: [String], environment: [String: String]? = nil, enabled: Bool? = nil, timeout: Int? = nil) {
        self.type = type
        self.command = command
        self.environment = environment
        self.enabled = enabled
        self.timeout = timeout
    }

}

public struct McpRemoteConfig: Codable, Sendable {
    public let type: String
    public let url: String
    public let enabled: Bool?
    public let headers: [String: String]?
    public let oauth: McpOAuthConfig?
    public let timeout: Int?
    
    public init(type: String = "remote", url: String, enabled: Bool? = nil, headers: [String: String]? = nil, oauth: McpOAuthConfig? = nil, timeout: Int? = nil) {
        self.type = type
        self.url = url
        self.enabled = enabled
        self.headers = headers
        self.oauth = oauth
        self.timeout = timeout
    }

}

public struct McpOAuthConfig: Codable, Sendable {
    public let clientId: String?
    public let clientSecret: String?
    public let scope: String?
    
    public init(clientId: String? = nil, clientSecret: String? = nil, scope: String? = nil) {
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.scope = scope
    }

}

public struct McpAddRequest: Codable, Sendable {
    public let name: String
    public let config: McpConfig
    
    public init(name: String, config: McpConfig) {
        self.name = name
        self.config = config
    }

}