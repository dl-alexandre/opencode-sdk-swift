import Foundation

public struct QuestionRequest: Codable, Sendable {
    public let id: String
    public let sessionID: String
    public let questions: [QuestionInfo]
    public let tool: PermissionRequestTool
    
    public init(id: String, sessionID: String, questions: [QuestionInfo], tool: PermissionRequestTool) {
        self.id = id
        self.sessionID = sessionID
        self.questions = questions
        self.tool = tool
    }

}

public struct QuestionInfo: Codable, Sendable {
    public let question: String
    public let header: String
    public let options: [QuestionOption]
    public let multiple: Bool?
    
    public init(question: String, header: String, options: [QuestionOption], multiple: Bool? = nil) {
        self.question = question
        self.header = header
        self.options = options
        self.multiple = multiple
    }

}

public struct QuestionOption: Codable, Sendable {
    public let label: String
    public let description: String
    
    public init(label: String, description: String) {
        self.label = label
        self.description = description
    }

}

public struct QuestionAnswer: Codable, Sendable {
    public let question: String
    public let answer: String
    
    public init(question: String, answer: String) {
        self.question = question
        self.answer = answer
    }
}

public struct QuestionReplyRequest: Codable, Sendable {
    public let answers: [QuestionAnswer]
    
    public init(answers: [QuestionAnswer]) {
        self.answers = answers
    }
}