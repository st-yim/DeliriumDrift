//
//  GPTService.swift
//  DeliriumDrift
//
//  Created by Steven Yim on 1/10/24.
//

import OpenAIKit

class GPTService {
    private let apiKey: String
    private let apiOrg: String
    private let apiUrl = URL(string: "https://api.openai.com/v1/chat/completions")!
    
    init(apiKey: String, apiOrg: String) {
        self.apiKey = apiKey
        self.apiOrg = apiOrg
    }

    func makeChatCompletionsCall(prompt: String, completion: @escaping (String) -> Void, errorHandler: @escaping (Error) -> Void) {
        let openAI = OpenAIKit(apiToken: apiKey, organization: apiOrg)
        
        openAI.sendChatCompletion(
            newMessage: AIMessage(role: .user, content: prompt),
            previousMessages: [],
            model: .gptV3_5(.gptTurbo),
            maxTokens: 2048,
            n: 1
        ) { result in
            switch result {
            case .success(let aiResult):
                if let text = aiResult.choices.first?.message?.content {
                    completion(text)
                }
            case .failure(let error):
                errorHandler(error)
            }
        }
    }
}



enum GPTServiceError: Error {
    case unknownError
    case invalidResponseFormat
}
