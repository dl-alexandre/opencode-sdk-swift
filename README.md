# OpenCode Swift SDK

A Swift client library for interacting with the OpenCode API. Built with Swift Concurrency for modern, type-safe, and thread-safe API interactions.

## Features

- **Swift Concurrency**: Built on `async/await` and actors for safe concurrent operations
- **Type-Safe**: Strongly typed models and requests with Codable support
- **Resource-Based API**: Organized API methods by resource (sessions, files, commands, etc.)
- **Batch Operations**: Execute multiple requests concurrently with configurable concurrency limits
- **Request Context**: Support for request IDs, correlation IDs, and user IDs via TaskLocal values
- **Comprehensive Error Handling**: Structured error types for network, encoding, and decoding failures
- **Swift 6.2**: Requires Swift 6.2 or later

## Requirements

- macOS 12.0+ (for Swift Concurrency support)
- Swift 6.2+

## Installation

### Swift Package Manager

Add the following to your `Package.swift` dependencies:

```swift
dependencies: [
    .package(url: "https://github.com/dl-alexandre/opencode-sdk-swift.git", from: "1.0.0")
]
```

Or add it via Xcode:
1. File → Add Package Dependencies...
2. Enter the repository URL
3. Select the version or branch

## Quick Start

```swift
import Foundation
import opencode_sdk_swift

@available(macOS 12.0, *)
func example() async throws {
    let configuration = OpenCodeConfiguration(
        baseURL: URL(string: "https://api.opencode.ai")!,
        apiKey: "your-api-key"
    )
    
    let client = OpenCodeClient(configuration: configuration)
    
    let sessions = try await client.session.list()
    print("Found \(sessions.count) sessions")
}
```

## Configuration

Create an `OpenCodeConfiguration` to configure the client:

```swift
let configuration = OpenCodeConfiguration(
    baseURL: URL(string: "https://api.opencode.ai")!,
    apiKey: "your-api-key",
    apiKeyHeader: "Authorization",  // Default
    apiKeyPrefix: "Bearer",          // Default
    userAgent: "MyApp/1.0",          // Optional
    timeout: 60                      // Default: 60 seconds
)
```

### Configuration Options

- `baseURL`: The base URL for the OpenCode API
- `apiKey`: Your API key
- `apiKeyHeader`: HTTP header name for the API key (default: `"Authorization"`)
- `apiKeyPrefix`: Prefix for the API key value (default: `"Bearer"`)
- `userAgent`: Optional custom user agent string
- `timeout`: Request timeout in seconds (default: `60`)

## Usage

### Sessions

Manage coding sessions:

```swift
let client = OpenCodeClient(configuration: configuration)

let sessions = try await client.session.list()
let session = try await client.session.get(sessionID: "session-id")
let newSession = try await client.session.create(
    request: SessionCreateRequest(...)
)
try await client.session.delete(sessionID: "session-id")
```

### Files

Work with files:

```swift
let files = try await client.file.list(path: "/project")
let content = try await client.file.read(path: "/project/file.swift")
let status = try await client.file.status()
```

### Commands

Execute commands:

```swift
let message = try await client.session.command(
    sessionID: "session-id",
    request: SessionCommandRequest(command: "ls -la")
)
```

### Batch Requests

Execute multiple requests concurrently:

```swift
let requests: [OpenCodeRequest<Session>] = [
    OpenCodeRequest(method: .get, path: "/session/1"),
    OpenCodeRequest(method: .get, path: "/session/2"),
    OpenCodeRequest(method: .get, path: "/session/3")
]

let sessions = try await client.sendBatch(requests)

let sessionsWithLimit = try await client.sendBatch(
    requests,
    maxConcurrency: 2
)
```

## Request Context

Use `RequestContext` to set request metadata that propagates through async operations:

```swift
await RequestContext.$requestID.withValue("custom-request-id") {
    await RequestContext.$correlationID.withValue("correlation-123") {
        await RequestContext.$userID.withValue("user-456") {
            let session = try await client.session.get(sessionID: "session-id")
        }
    }
}
```

The client automatically includes:
- `X-Request-ID`: Generated UUID if not provided
- `X-Correlation-ID`: Included if set in context

## Error Handling

The SDK uses `OpenCodeError` for structured error handling:

```swift
do {
    let session = try await client.session.get(sessionID: "session-id")
} catch OpenCodeError.encodingFailed(let underlying) {
    print("Encoding failed: \(underlying)")
} catch OpenCodeError.decodingFailed(let underlying, let data) {
    print("Decoding failed: \(underlying)")
    print("Response data: \(String(data: data, encoding: .utf8) ?? "")")
} catch OpenCodeError.transportFailed(let underlying) {
    print("Network error: \(underlying)")
} catch OpenCodeError.invalidResponse(let statusCode, let data) {
    print("Invalid response: \(statusCode)")
} catch {
    print("Unknown error: \(error)")
}
```

### Error Types

- `.encodingFailed(underlying: Error)`: Request body encoding failed
- `.decodingFailed(underlying: Error, data: Data)`: Response decoding failed
- `.transportFailed(underlying: Error)`: Network transport error
- `.invalidResponse(statusCode: Int, data: Data)`: Non-2xx HTTP response
- `.invalidURL`: Invalid URL construction

## API Resources

The SDK provides resource-based APIs for:

- **Sessions**: Create, list, get, update, delete sessions
- **Files**: List, read, check status
- **Commands**: Execute shell commands
- **Messages**: Send prompts, retrieve messages
- **Projects**: Project management
- **Config**: Configuration management
- **Auth**: Authentication
- **LSP**: Language Server Protocol operations
- **MCP**: Model Context Protocol
- **Tools**: Tool management
- **And more**: See `Sources/opencode-sdk-swift/Resources/` for complete list

## Architecture

- **Core**: Client, configuration, request building, error handling
- **Models**: Codable data models for API requests and responses
- **Resources**: Resource-specific API methods organized by domain

## Building and Testing

Build the package:

```bash
swift build
```

Run all tests:

```bash
swift test
```

Run a specific test:

```bash
swift test --filter testName
```

Clean build artifacts:

```bash
swift package clean
```

## License

[Add your license here]

## Contributing

[Add contribution guidelines here]
