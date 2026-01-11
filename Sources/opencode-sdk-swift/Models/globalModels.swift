import Foundation

public struct HealthResponse: Codable, Sendable {
    public let healthy: Bool
    public let version: String
    
    public init(healthy: Bool, version: String) {
        self.healthy = healthy
        self.version = version
    }

}