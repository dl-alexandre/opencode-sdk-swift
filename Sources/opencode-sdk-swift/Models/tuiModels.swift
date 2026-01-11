import Foundation

public struct TuiAppendPromptRequest: Codable, Sendable {
    public let text: String
    
    public init(text: String) {
        self.text = text
    }

}

public struct TuiShowToastRequest: Codable, Sendable {
    public let title: String?
    public let message: String
    public let variant: ToastVariant
    public let duration: Int?
    
    public init(title: String? = nil, message: String, variant: ToastVariant, duration: Int? = nil) {
        self.title = title
        self.message = message
        self.variant = variant
        self.duration = duration
    }

}

public enum ToastVariant: String, Codable, Sendable {
    case info
    case success
    case warning
    case error
}

public struct TuiExecuteCommandRequest: Codable, Sendable {
    public let command: String
    
    public init(command: String) {
        self.command = command
    }

}

public struct TuiSelectSessionRequest: Codable, Sendable {
    public let sessionID: String
    
    public init(sessionID: String) {
        self.sessionID = sessionID
    }

}