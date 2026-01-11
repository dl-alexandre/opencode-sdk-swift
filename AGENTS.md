# AGENTS

This file guides agentic coding assistants working in this repo.

## Repository Overview
- Swift Package Manager library target: `opencode-sdk-swift`.
- Swift tools version: `6.2` (`Package.swift`).
- Source code: `Sources/opencode-sdk-swift/`.
- Core networking/client logic: `Sources/opencode-sdk-swift/Core`.
- Data models: `Sources/opencode-sdk-swift/Models`.
- API request builders/resources: `Sources/opencode-sdk-swift/Resources`.
- Tests: `Tests/opencode-sdk-swiftTests` using the Swift `Testing` package.

## Build / Lint / Test Commands
- Build: `swift build`.
- Run all tests: `swift test`.
- Run a single test by name: `swift test --filter makeURLRequestBuildsPathAndQuery`.
- Run all tests in the suite: `swift test --filter opencode_sdk_swiftTests`.
- Clean build artifacts: `swift package clean`.
- Linting: no repo-defined lint config (no SwiftLint/SwiftFormat config checked in).
- Formatting: follow existing style; do not introduce formatter configs without asking.

## Code Style
### Imports
- Usually only `import Foundation` per file.
- Keep imports grouped without blank lines between them.

### Formatting
- 4-space indentation, no tabs.
- Opening braces on the same line; closing braces on their own line.
- Keep one blank line between type declarations.
- Keep a blank line between stored properties and `init`/methods.
- Multi-line parameter lists align with the opening parenthesis and close on a new line.
- Avoid trailing commas in argument lists and arrays (match existing code).

### Naming
- Types use UpperCamelCase (e.g., `OpenCodeClient`, `McpRemoteConfig`).
- Properties and locals use lowerCamelCase.
- Initialisms keep mixed-case (e.g., `sessionID`, `userID`, `apiKey`).
- File names are lowerCamelCase with suffixes like `Models` or `Resources`.

### Access Control
- Explicitly mark public API types/functions as `public`.
- Use `private` for helpers scoped to a type.
- Avoid `internal` keywords unless needed for clarity.

### Types and Defaults
- Most data types conform to `Codable` and `Sendable`.
- Provide explicit memberwise `init` methods.
- Default optional parameters to `nil` in `init` signatures.
- Prefer explicit integer types used in models (e.g., `Int64` for timestamps).

### Codable Conventions
- Use `CodingKeys` when JSON keys differ from Swift names.
- For enums with discriminators, implement custom `init(from:)` and `encode(to:)`.
- Keep decoding/encoding logic symmetrical.
- Prefer single-value containers when modeling polymorphic values.
- Use `AnyCodable`/`AnyEncodable` for dynamic JSON payloads.

### Error Handling
- Use `OpenCodeError` for network/serialization failures.
- Wrap underlying errors in `.encodingFailed`, `.decodingFailed`, `.transportFailed`.
- Prefer `guard` + throw for invalid states.
- Use `DecodingError.dataCorruptedError` for invalid payloads.
- Avoid swallowing errors or returning partial data.

### Concurrency
- The client uses Swift Concurrency (`actor`, `TaskLocal`, `async/await`).
- Mark async APIs with `@available(macOS 12.0, *)` when needed.
- Use `Task.checkCancellation()` in long-running operations.
- Handle cancellation explicitly (`Task.isCancelled`).
- Keep `Sendable` conformance on shared value types.

### Networking
- Build requests via `OpenCodeRequest` and `OpenCodeConfiguration`.
- Normalize request paths to include a leading `/`.
- Always set `Accept: application/json`.
- Set `Content-Type: application/json` when a body exists.
- Use `JSONEncoder`/`JSONDecoder` with `.iso8601` for dates (see client).

### Requests & Resources
- Resource files should only build request data (no network calls).
- Keep resource helpers pure and small; avoid hidden state.
- Prefer `AnyEncodable` for request bodies with dynamic JSON.
- Use `URLQueryItem` for query parameters.
- Keep headers in `[String: String]` dictionaries.
- Request paths can be relative; the client normalizes leading `/`.

### Configuration Defaults
- `OpenCodeConfiguration` defaults `apiKeyHeader` to `Authorization`.
- `apiKeyPrefix` defaults to `Bearer` unless explicitly nil/empty.
- `userAgent` is optional; only set when needed.
- Default `timeout` is 60 seconds; override for long requests.

## Testing Conventions
- Tests use the Swift `Testing` module (`@Test`, `#expect`).
- Prefer async tests for async APIs.
- Use `@testable import opencode_sdk_swift` in tests.
- Keep test functions top-level (no XCTest subclasses).
- Name tests descriptively (verb + behavior).

## Documentation
- README is currently empty; do not auto-generate docs unless asked.
- Update public API docs only when requested.

## Repository Hygiene
- Avoid introducing new dependencies without approval.
- Keep edits limited to the requested task scope.
- Do not rename files or public symbols unless requested.
- Keep changes consistent with existing file organization.

## Cursor/Copilot Rules
- No `.cursor/rules`, `.cursorrules`, or `.github/copilot-instructions.md` found.
- If these files appear later, follow them.

<skills_system priority="1">

## Available Skills

<!-- SKILLS_TABLE_START -->
<usage>
When users ask you to perform tasks, check if any of the available skills below can help complete the task more effectively. Skills provide specialized capabilities and domain knowledge.

How to use skills:
- Invoke: Bash("openskills read <skill-name>")
- The skill content will load with detailed instructions on how to complete the task
- Base directory provided in output for resolving bundled resources (references/, scripts/, assets/)

Usage notes:
- Only use skills listed in <available_skills> below
- Do not invoke a skill that is already loaded in your context
- Each skill invocation is stateless
</usage>

<available_skills>

<skill>
<name>swift-concurrency</name>
<description>'Expert guidance on Swift Concurrency best practices, patterns, and implementation. Use when developers mention: (1) Swift Concurrency, async/await, actors, or tasks, (2) "use Swift Concurrency" or "modern concurrency patterns", (3) migrating to Swift 6, (4) data races or thread safety issues, (5) refactoring closures to async/await, (6) @MainActor, Sendable, or actor isolation, (7) concurrent code architecture or performance optimization, (8) concurrency-related linter warnings (SwiftLint or similar; e.g. async_without_await, Sendable/actor isolation/MainActor lint).'</description>
<location>project</location>
</skill>

</available_skills>
<!-- SKILLS_TABLE_END -->

</skills_system>
