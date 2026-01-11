import Foundation

public struct Auth: Codable, Sendable {
    public let type: String
    public let key: String?
    public let token: String?
    public let refresh: String?
    public let access: String?
    public let expires: Int64?
    public let accountId: String?
    public let enterpriseUrl: String?
    
    public init(type: String, key: String? = nil, token: String? = nil, refresh: String? = nil, access: String? = nil, expires: Int64? = nil, accountId: String? = nil, enterpriseUrl: String? = nil) {
        self.type = type
        self.key = key
        self.token = token
        self.refresh = refresh
        self.access = access
        self.expires = expires
        self.accountId = accountId
        self.enterpriseUrl = enterpriseUrl
    }

}