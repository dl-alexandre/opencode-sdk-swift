import Foundation

public struct BadRequestError: Codable {
    public let data: [String: AnyCodable]
    public let errors: [[String: AnyCodable]]
    public let success: Bool
    
    public init(data: [String: AnyCodable], errors: [[String: AnyCodable]], success: Bool) {
        self.data = data
        self.errors = errors
        self.success = success
    }

}

public struct NotFoundError: Codable, Sendable {
    public let name: String
    public let data: NotFoundErrorData
    
    public init(name: String, data: NotFoundErrorData) {
        self.name = name
        self.data = data
    }

}

public struct NotFoundErrorData: Codable, Sendable {
    public let message: String
    
    public init(message: String) {
        self.message = message
    }

}