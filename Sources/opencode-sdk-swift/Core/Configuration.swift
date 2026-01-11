import Foundation

public struct OpenCodeConfiguration: Sendable {
    public let baseURL: URL
    public let apiKey: String
    public let apiKeyHeader: String
    public let apiKeyPrefix: String?
    public let userAgent: String?
    public let timeout: TimeInterval

    public init(
        baseURL: URL,
        apiKey: String,
        apiKeyHeader: String = "Authorization",
        apiKeyPrefix: String? = "Bearer",
        userAgent: String? = nil,
        timeout: TimeInterval = 60
    ) {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.apiKeyHeader = apiKeyHeader
        self.apiKeyPrefix = apiKeyPrefix
        self.userAgent = userAgent
        self.timeout = timeout
    }
}
