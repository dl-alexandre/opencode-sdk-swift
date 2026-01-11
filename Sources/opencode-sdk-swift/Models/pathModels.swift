import Foundation

public struct Path: Codable, Sendable {
    public let home: String
    public let state: String
    public let config: String
    public let worktree: String
    public let directory: String
    
    public init(home: String, state: String, config: String, worktree: String, directory: String) {
        self.home = home
        self.state = state
        self.config = config
        self.worktree = worktree
        self.directory = directory
    }

}

public struct Worktree: Codable, Sendable {
    public let name: String
    public let branch: String
    public let directory: String
    
    public init(name: String, branch: String, directory: String) {
        self.name = name
        self.branch = branch
        self.directory = directory
    }

}

public struct WorktreeCreateInput: Codable, Sendable {
    public let name: String?
    public let startCommand: String?
    
    public init(name: String? = nil, startCommand: String? = nil) {
        self.name = name
        self.startCommand = startCommand
    }

}

public struct VcsInfo: Codable, Sendable {
    public let branch: String
    
    public init(branch: String) {
        self.branch = branch
    }

}