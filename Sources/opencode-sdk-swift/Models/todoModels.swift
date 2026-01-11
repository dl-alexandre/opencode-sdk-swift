import Foundation

public struct Todo: Codable, Sendable {
    public let content: String
    public let status: String
    public let priority: String
    public let id: String
    
    public init(content: String, status: String, priority: String, id: String) {
        self.content = content
        self.status = status
        self.priority = priority
        self.id = id
    }

}