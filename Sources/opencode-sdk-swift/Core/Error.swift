import Foundation

public enum OpenCodeError: Error, LocalizedError, Sendable {
    case invalidURL
    case invalidResponse(statusCode: Int, data: Data)
    case decodingFailed(underlying: Error, data: Data)
    case encodingFailed(underlying: Error)
    case transportFailed(underlying: Error)

    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse(let statusCode, _):
            return "Unexpected response status: \(statusCode)"
        case .decodingFailed(let underlying, _):
            return "Failed to decode response: \(underlying.localizedDescription)"
        case .encodingFailed(let underlying):
            return "Failed to encode request: \(underlying.localizedDescription)"
        case .transportFailed(let underlying):
            return "Transport error: \(underlying.localizedDescription)"
        }
    }
}
