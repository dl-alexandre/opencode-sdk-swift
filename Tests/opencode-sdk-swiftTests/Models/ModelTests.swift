import Foundation
import Testing
@testable import opencode_sdk_swift

@Test func modelAnyCodableEncodingDecoding() async throws {
    let encoder = TestHelpers.makeEncoder()
    let decoder = TestHelpers.makeDecoder()
    
    let original: AnyCodable = .dictionary([
        "string": .string("value"),
        "int": .int(42),
        "bool": .bool(true),
        "array": .array([.string("item1"), .int(123)]),
        "null": .null
    ])
    
    let encoded = try encoder.encode(original)
    let decoded = try decoder.decode(AnyCodable.self, from: encoded)
    
    if case .dictionary(let dict) = decoded {
        #expect(dict["string"] != nil)
        if case .string("value") = dict["string"] ?? .null {
            #expect(true)
        }
        #expect(dict["int"] != nil)
        if case .int(42) = dict["int"] ?? .null {
            #expect(true)
        }
        #expect(dict["bool"] != nil)
        if case .bool(true) = dict["bool"] ?? .null {
            #expect(true)
        }
        #expect(dict["null"] != nil)
        if case .null = dict["null"] ?? .string("") {
            #expect(true)
        }
    } else {
        Issue.record("Expected dictionary")
    }
}

@Test func modelAnyCodableRoundTrip() async throws {
    let encoder = TestHelpers.makeEncoder()
    let decoder = TestHelpers.makeDecoder()
    
    let testCases: [(AnyCodable, (AnyCodable) -> Bool)] = [
        (.string("test"), { if case .string("test") = $0 { return true } else { return false } }),
        (.int(42), { if case .int(42) = $0 { return true } else { return false } }),
        (.double(3.14), { if case .double(3.14) = $0 { return true } else { return false } }),
        (.bool(true), { if case .bool(true) = $0 { return true } else { return false } }),
        (.array([.string("a"), .int(1)]), {
            if case .array(let arr) = $0, arr.count == 2 {
                if case .string("a") = arr[0], case .int(1) = arr[1] {
                    return true
                }
            }
            return false
        }),
        (.dictionary(["key": .string("value")]), {
            if case .dictionary(let dict) = $0 {
                if case .string("value") = dict["key"] ?? .null {
                    return true
                }
            }
            return false
        }),
        (.null, { if case .null = $0 { return true } else { return false } })
    ]
    
    for (original, validator) in testCases {
        let encoded = try encoder.encode(original)
        let decoded = try decoder.decode(AnyCodable.self, from: encoded)
        #expect(validator(decoded))
    }
}

@Test func modelPartTimeEncodingDecoding() async throws {
    let encoder = TestHelpers.makeEncoder()
    let decoder = TestHelpers.makeDecoder()
    
    let original = PartTime(start: 1234567890, end: 1234567900)
    let encoded = try encoder.encode(original)
    let decoded = try decoder.decode(PartTime.self, from: encoded)
    
    #expect(decoded.start == original.start)
    #expect(decoded.end == original.end)
}

@Test func modelPartTimeEncodingDecodingWithoutEnd() async throws {
    let encoder = TestHelpers.makeEncoder()
    let decoder = TestHelpers.makeDecoder()
    
    let original = PartTime(start: 1234567890, end: nil)
    let encoded = try encoder.encode(original)
    let decoded = try decoder.decode(PartTime.self, from: encoded)
    
    #expect(decoded.start == original.start)
    #expect(decoded.end == nil)
}

@Test func modelTextPartEncodingDecoding() async throws {
    let encoder = TestHelpers.makeEncoder()
    let decoder = TestHelpers.makeDecoder()
    
    let metadata: [String: AnyCodable] = [
        "key1": .string("value1"),
        "key2": .int(42)
    ]
    
    let original = TextPart(
        id: "part-1",
        sessionID: "session-1",
        messageID: "message-1",
        type: "text",
        text: "Hello, world!",
        synthetic: true,
        ignored: false,
        time: PartTime(start: 1234567890, end: 1234567900),
        metadata: metadata
    )
    
    let encoded = try encoder.encode(original)
    let decoded = try decoder.decode(TextPart.self, from: encoded)
    
    #expect(decoded.id == original.id)
    #expect(decoded.sessionID == original.sessionID)
    #expect(decoded.messageID == original.messageID)
    #expect(decoded.type == original.type)
    #expect(decoded.text == original.text)
    #expect(decoded.synthetic == original.synthetic)
    #expect(decoded.ignored == original.ignored)
    #expect(decoded.time?.start == original.time?.start)
    #expect(decoded.time?.end == original.time?.end)
}

@Test func modelMessageInfoUserEncodingDecoding() async throws {
    let encoder = TestHelpers.makeEncoder()
    let decoder = TestHelpers.makeDecoder()
    
    let userMessage = UserMessage(
        id: "msg-1",
        sessionID: "session-1",
        role: "user",
        time: MessageTime(created: 1234567890),
        agent: "agent-1",
        model: ModelInfo(providerID: "provider-1", modelID: "model-1")
    )
    
    let original = MessageInfo.user(userMessage)
    let encoded = try encoder.encode(original)
    let decoded = try decoder.decode(MessageInfo.self, from: encoded)
    
    if case .user(let decodedMessage) = decoded {
        #expect(decodedMessage.id == userMessage.id)
        #expect(decodedMessage.sessionID == userMessage.sessionID)
        #expect(decodedMessage.role == userMessage.role)
    } else {
        Issue.record("Expected user message")
    }
}
