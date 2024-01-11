//
//  GPTService.swift
//  DeliriumDrift
//
//  Created by Steven Yim on 1/10/24.
//

import Foundation

class GPTService {
    let apiKey = "YOUR_OPENAI_API_KEY"
    let endpoint = "https://api.openai.com/v1/engines/davinci/completions"
    
    func generateRelatedWords(inputText: String, completion: @escaping (Result<[String], Error>) -> Void) {
        let url = URL(string: endpoint)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestData: [String: Any] = [
            "prompt": inputText,
            "temperature": 0.3,
            "max_tokens": 10
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestData)
        } catch {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "NetworkError", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let generatedText = jsonResponse["choices"] as? [String]
                completion(.success(generatedText ?? [])) // Return an empty array if generatedText is nil
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
