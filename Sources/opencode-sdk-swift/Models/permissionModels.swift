import Foundation

public struct PermissionRequest: Codable, Sendable {
    public let id: String
    public let sessionID: String
    public let permission: String
    public let patterns: [String]
    public let metadata: [String: AnyCodable]
    public let always: [String]
    public let tool: PermissionRequestTool
    
    public init(id: String, sessionID: String, permission: String, patterns: [String], metadata: [String: AnyCodable], always: [String], tool: PermissionRequestTool) {
        self.id = id
        self.sessionID = sessionID
        self.permission = permission
        self.patterns = patterns
        self.metadata = metadata
        self.always = always
        self.tool = tool
    }
}

public struct PermissionRequestTool: Codable, Sendable {
    public let messageID: String
    public let callID: String
    
    public init(messageID: String, callID: String) {
        self.messageID = messageID
        self.callID = callID
    }
}

public struct PermissionReplyRequest: Codable, Sendable {
    public let reply: PermissionReply
    public let message: String?
    
    public init(reply: PermissionReply, message: String? = nil) {
        self.reply = reply
        self.message = message
    }
}

public enum PermissionReply: String, Codable, Sendable {
    case allow
    case deny
}
