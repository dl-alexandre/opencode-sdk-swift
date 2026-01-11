import Foundation

public struct SymbolLocation: Codable, Sendable {
    public let uri: String
    public let range: opencode_sdk_swift.Range
    
    public init(uri: String, range: opencode_sdk_swift.Range) {
        self.uri = uri
        self.range = range
    }

}

public struct FileNode: Codable, Sendable {
    public let name: String
    public let path: String
    public let absolute: String
    public let type: FileNodeType
    public let ignored: Bool
    
    public init(name: String, path: String, absolute: String, type: FileNodeType, ignored: Bool) {
        self.name = name
        self.path = path
        self.absolute = absolute
        self.type = type
        self.ignored = ignored
    }

}

public enum FileNodeType: String, Codable, Sendable {
    case file
    case directory
}

public struct FileContent: Codable, Sendable {
    public let type: String
    public let content: String
    public let diff: String?
    public let patch: FilePatch?
    public let encoding: String?
    public let mimeType: String?
    
    public init(type: String, content: String, diff: String? = nil, patch: FilePatch? = nil, encoding: String? = nil, mimeType: String? = nil) {
        self.type = type
        self.content = content
        self.diff = diff
        self.patch = patch
        self.encoding = encoding
        self.mimeType = mimeType
    }

}

public struct FilePatch: Codable, Sendable {
    public let oldFileName: String
    public let newFileName: String
    public let oldHeader: String
    public let newHeader: String
    public let hunks: [FilePatchHunk]
    public let index: String?
    
    public init(oldFileName: String, newFileName: String, oldHeader: String, newHeader: String, hunks: [FilePatchHunk], index: String? = nil) {
        self.oldFileName = oldFileName
        self.newFileName = newFileName
        self.oldHeader = oldHeader
        self.newHeader = newHeader
        self.hunks = hunks
        self.index = index
    }

}

public struct FilePatchHunk: Codable, Sendable {
    public let oldStart: Int
    public let oldLines: Int
    public let newStart: Int
    public let newLines: Int
    public let lines: [String]
    
    public init(oldStart: Int, oldLines: Int, newStart: Int, newLines: Int, lines: [String]) {
        self.oldStart = oldStart
        self.oldLines = oldLines
        self.newStart = newStart
        self.newLines = newLines
        self.lines = lines
    }

}

public struct FileDiff: Codable, Sendable {
    public let file: String
    public let before: String
    public let after: String
    public let additions: Int
    public let deletions: Int
    
    public init(file: String, before: String, after: String, additions: Int, deletions: Int) {
        self.file = file
        self.before = before
        self.after = after
        self.additions = additions
        self.deletions = deletions
    }

}

public enum FileStatus: String, Codable, Sendable {
    case added
    case deleted
    case modified
}

public struct File: Codable, Sendable {
    public let path: String
    public let status: FileStatus
    
    public init(path: String, status: FileStatus) {
        self.path = path
        self.status = status
    }
}

public struct Symbol: Codable, Sendable {
    public let name: String
    public let kind: Int
    public let location: SymbolLocation
    
    public init(name: String, kind: Int, location: SymbolLocation) {
        self.name = name
        self.kind = kind
        self.location = location
    }
}

