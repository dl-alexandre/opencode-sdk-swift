import Foundation

public struct Project: Codable, Sendable {
    public let id: String
    public let worktree: String
    public let vcs: String
    public let name: String?
    public let icon: ProjectIcon?
    public let time: ProjectTime
    public let sandboxes: [String]
    
    public init(id: String, worktree: String, vcs: String, name: String? = nil, icon: ProjectIcon? = nil, time: ProjectTime, sandboxes: [String]) {
        self.id = id
        self.worktree = worktree
        self.vcs = vcs
        self.name = name
        self.icon = icon
        self.time = time
        self.sandboxes = sandboxes
    }

}

public struct ProjectIcon: Codable, Sendable {
    public let url: String
    public let color: String
    
    public init(url: String, color: String) {
        self.url = url
        self.color = color
    }

}

public struct ProjectTime: Codable, Sendable {
    public let created: Int64
    public let updated: Int64
    public let initialized: Int64?
    
    public init(created: Int64, updated: Int64, initialized: Int64? = nil) {
        self.created = created
        self.updated = updated
        self.initialized = initialized
    }

}

public struct ProjectUpdateRequest: Codable, Sendable {
    public let name: String?
    public let icon: ProjectIcon?
    
    public init(name: String? = nil, icon: ProjectIcon? = nil) {
        self.name = name
        self.icon = icon
    }

}