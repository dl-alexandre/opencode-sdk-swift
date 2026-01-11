import Foundation

public struct Pty: Codable, Sendable {
    public let id: String
    public let title: String
    public let command: String
    public let args: [String]
    public let cwd: String
    public let status: PtyStatus
    public let pid: Int
    
    public init(id: String, title: String, command: String, args: [String], cwd: String, status: PtyStatus, pid: Int) {
        self.id = id
        self.title = title
        self.command = command
        self.args = args
        self.cwd = cwd
        self.status = status
        self.pid = pid
    }

}

public enum PtyStatus: String, Codable, Sendable {
    case running
    case exited
}

public struct PtyCreateRequest: Codable, Sendable {
    public let command: String?
    public let args: [String]?
    public let cwd: String?
    public let title: String?
    public let env: [String: String]?
    
    public init(command: String? = nil, args: [String]? = nil, cwd: String? = nil, title: String? = nil, env: [String: String]? = nil) {
        self.command = command
        self.args = args
        self.cwd = cwd
        self.title = title
        self.env = env
    }

}

public struct PtyUpdateRequest: Codable, Sendable {
    public let title: String?
    public let size: PtySize?
    
    public init(title: String? = nil, size: PtySize? = nil) {
        self.title = title
        self.size = size
    }

}

public struct PtySize: Codable, Sendable {
    public let rows: Int
    public let cols: Int
    
    public init(rows: Int, cols: Int) {
        self.rows = rows
        self.cols = cols
    }

}