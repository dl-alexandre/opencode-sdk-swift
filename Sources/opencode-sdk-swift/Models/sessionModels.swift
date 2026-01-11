import Foundation

public struct Session: Codable, Sendable {
    public let id: String
    public let projectID: String
    public let directory: String
    public let parentID: String?
    public let summary: SessionSummary?
    public let share: SessionShare?
    public let title: String
    public let version: String
    public let time: SessionTime
    public let permission: PermissionRuleset
    public let revert: SessionRevert?
    
    public init(id: String, projectID: String, directory: String, parentID: String? = nil, summary: SessionSummary? = nil, share: SessionShare? = nil, title: String, version: String, time: SessionTime, permission: PermissionRuleset, revert: SessionRevert? = nil) {
        self.id = id
        self.projectID = projectID
        self.directory = directory
        self.parentID = parentID
        self.summary = summary
        self.share = share
        self.title = title
        self.version = version
        self.time = time
        self.permission = permission
        self.revert = revert
    }

}

public struct SessionSummary: Codable, Sendable {
    public let additions: Int
    public let deletions: Int
    public let files: Int
    public let diffs: [opencode_sdk_swift.FileDiff]
    
    public init(additions: Int, deletions: Int, files: Int, diffs: [opencode_sdk_swift.FileDiff]) {
        self.additions = additions
        self.deletions = deletions
        self.files = files
        self.diffs = diffs
    }

}

public struct SessionShare: Codable, Sendable {
    public let url: String
    
    public init(url: String) {
        self.url = url
    }

}

public struct SessionTime: Codable, Sendable {
    public let created: Int64
    public let updated: Int64
    public let compacting: Int64?
    public let archived: Int64?
    
    public init(created: Int64, updated: Int64, compacting: Int64? = nil, archived: Int64? = nil) {
        self.created = created
        self.updated = updated
        self.compacting = compacting
        self.archived = archived
    }

}

public struct SessionRevert: Codable, Sendable {
    public let messageID: String
    public let partID: String?
    public let snapshot: String?
    public let diff: String?
    
    public init(messageID: String, partID: String? = nil, snapshot: String? = nil, diff: String? = nil) {
        self.messageID = messageID
        self.partID = partID
        self.snapshot = snapshot
        self.diff = diff
    }

}

public struct PermissionRule: Codable, Sendable {
    public let permission: String
    public let pattern: String
    public let action: PermissionAction
    
    public init(permission: String, pattern: String, action: PermissionAction) {
        self.permission = permission
        self.pattern = pattern
        self.action = action
    }

}

public enum PermissionAction: String, Codable, Sendable {
    case allow
    case deny
    case ask
}

public typealias PermissionRuleset = [PermissionRule]

public struct SessionCreateRequest: Codable, Sendable {
    public let parentID: String?
    public let title: String?
    public let permission: PermissionRuleset?
    
    public init(parentID: String? = nil, title: String? = nil, permission: PermissionRuleset? = nil) {
        self.parentID = parentID
        self.title = title
        self.permission = permission
    }

}

public struct SessionUpdateRequest: Codable, Sendable {
    public let title: String?
    public let time: SessionTimeUpdate?
    
    public init(title: String? = nil, time: SessionTimeUpdate? = nil) {
        self.title = title
        self.time = time
    }

}

public struct SessionTimeUpdate: Codable, Sendable {
    public let archived: Int64?
    
    public init(archived: Int64? = nil) {
        self.archived = archived
    }

}

public struct SessionStatus: Codable, Sendable {
    public let type: String
    public let attempt: Int?
    public let message: String?
    public let next: Int64?
    
    public init(type: String, attempt: Int? = nil, message: String? = nil, next: Int64? = nil) {
        self.type = type
        self.attempt = attempt
        self.message = message
        self.next = next
    }

}

public struct SessionRevertRequest: Codable, Sendable {
    public let messageID: String
    public let partID: String?
    
    public init(messageID: String, partID: String? = nil) {
        self.messageID = messageID
        self.partID = partID
    }

}

public struct SessionSummarizeRequest: Codable, Sendable {
    public let providerID: String
    public let modelID: String
    public let auto: Bool?
    
    public init(providerID: String, modelID: String, auto: Bool? = nil) {
        self.providerID = providerID
        self.modelID = modelID
        self.auto = auto
    }

}

public struct SessionForkRequest: Codable, Sendable {
    public let messageID: String
    
    public init(messageID: String) {
        self.messageID = messageID
    }

}

public struct SessionInitRequest: Codable, Sendable {
    public let modelID: String
    public let providerID: String
    public let messageID: String?
    
    public init(modelID: String, providerID: String, messageID: String? = nil) {
        self.modelID = modelID
        self.providerID = providerID
        self.messageID = messageID
    }

}

public struct SessionCommandRequest: Codable, Sendable {
    public let messageID: String?
    public let agent: String?
    public let model: String?
    public let arguments: String
    public let command: String
    public let variant: String?
    public let parts: [FilePartInput]?
    
    public init(messageID: String? = nil, agent: String? = nil, model: String? = nil, arguments: String, command: String, variant: String? = nil, parts: [FilePartInput]? = nil) {
        self.messageID = messageID
        self.agent = agent
        self.model = model
        self.arguments = arguments
        self.command = command
        self.variant = variant
        self.parts = parts
    }

}

public struct SessionPromptRequest: Codable, Sendable {
    public let messageID: String?
    public let agent: String?
    public let model: String?
    public let parts: [PartInput]
    public let stream: Bool?
    
    public init(messageID: String? = nil, agent: String? = nil, model: String? = nil, parts: [PartInput], stream: Bool? = nil) {
        self.messageID = messageID
        self.agent = agent
        self.model = model
        self.parts = parts
        self.stream = stream
    }
}

public struct SessionShellRequest: Codable, Sendable {
    public let agent: String
    public let command: String
    public let model: opencode_sdk_swift.ModelInfo?
    
    public init(agent: String, command: String, model: opencode_sdk_swift.ModelInfo? = nil) {
        self.agent = agent
        self.command = command
        self.model = model
    }
}