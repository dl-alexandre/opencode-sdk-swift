import Foundation

public struct Command: Codable, Sendable {
    public let name: String
    public let description: String
    public let agent: String?
    public let model: String?
    public let mcp: Bool?
    public let template: String
    public let subtask: Bool?
    public let hints: [String]
    
    public init(name: String, description: String, agent: String? = nil, model: String? = nil, mcp: Bool? = nil, template: String, subtask: Bool? = nil, hints: [String]) {
        self.name = name
        self.description = description
        self.agent = agent
        self.model = model
        self.mcp = mcp
        self.template = template
        self.subtask = subtask
        self.hints = hints
    }

}