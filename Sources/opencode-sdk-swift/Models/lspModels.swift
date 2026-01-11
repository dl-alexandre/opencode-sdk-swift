import Foundation

public struct LSPStatus: Codable, Sendable {
    public let id: String
    public let name: String
    public let root: String
    public let status: String
    
    public init(id: String, name: String, root: String, status: String) {
        self.id = id
        self.name = name
        self.root = root
        self.status = status
    }

}

public struct FormatterStatus: Codable, Sendable {
    public let name: String
    public let extensions: [String]
    public let enabled: Bool
    
    public init(name: String, extensions: [String], enabled: Bool) {
        self.name = name
        self.extensions = extensions
        self.enabled = enabled
    }

}