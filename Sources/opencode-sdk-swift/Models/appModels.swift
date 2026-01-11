import Foundation

public struct AppLogRequest: Codable, Sendable {
    public let service: String
    public let level: LogLevel
    public let message: String
    public let extra: [String: AnyCodable]?
    
    public init(service: String, level: LogLevel, message: String, extra: [String: AnyCodable]? = nil) {
        self.service = service
        self.level = level
        self.message = message
        self.extra = extra
    }

}

public enum LogLevel: String, Codable, Sendable {
    case debug
    case info
    case error
    case warn
}
