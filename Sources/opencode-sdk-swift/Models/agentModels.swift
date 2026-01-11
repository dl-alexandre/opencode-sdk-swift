import Foundation

public struct Agent: Codable, Sendable {
    public let name: String
    public let description: String?
    public let mode: String
    public let native: Bool?
    public let hidden: Bool?
    public let topP: Double?
    public let temperature: Double?
    public let color: String?
    public let permission: PermissionRuleset
    public let model: ModelInfo?
    public let prompt: String?
    public let options: [String: AnyCodable]
    public let steps: Int?
    
    public init(name: String, description: String? = nil, mode: String, native: Bool? = nil, hidden: Bool? = nil, topP: Double? = nil, temperature: Double? = nil, color: String? = nil, permission: PermissionRuleset, model: ModelInfo? = nil, prompt: String? = nil, options: [String: AnyCodable], steps: Int? = nil) {
        self.name = name
        self.description = description
        self.mode = mode
        self.native = native
        self.hidden = hidden
        self.topP = topP
        self.temperature = temperature
        self.color = color
        self.permission = permission
        self.model = model
        self.prompt = prompt
        self.options = options
        self.steps = steps
    }
}
