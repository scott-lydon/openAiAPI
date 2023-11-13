//
//  URLRequest.swift
//  
//
//  Created by Scott Lydon on 11/12/23.
//

import Foundation

// URLRequest extension to create an OpenAI API request
extension URLRequest {


    /// Basic gpt 3.5 builder.
    /// - Parameter text: "The prompt you want to give to gpt"
    /// - Returns: The URLRequest you are creating.
    static func gptBuilder(_ text: String) -> URLRequest {
        URLRequest.gpt35TurboChatRequest(
            messages: .buildUserMessage(
                content: text
            )
        )
    }

    /// Gets  the available models.
    static var models: URLRequest {
        .standardOpenAiRequest(
            url: .models(),
            httpMethod: "GET"
        )
    }

    /// This method fascilitates the creation of open ai api calls.
    /// - Parameters:
    ///   - url: open ai url to use to build the request.
    ///   - prompt: The text prompt to send to the API
    ///   - maxTokens: The maximum number of tokens (words or word pieces) to generate
    ///   - n: The number of generated responses to return
    ///   - stop: The sequence(s) where the API should stop generating tokens
    /// - Returns: The open ai request.
    static func openAIRequest(
        url: URL = .davinci(),
        prompt: String,
        maxTokens: Int = 50,
        n: Int = 1,
        stop: [String] = ["\n"]
    ) -> URLRequest {

        // Configure the API request
        var request = URLRequest.standardOpenAiRequest(url: url)

        // Set the parameters for the API call
        let parameters: [String: Any] = [
            "prompt": prompt,
            "max_tokens": maxTokens,
            "n": n,
            "stop": stop
        ]

        // Encode the parameters as JSON
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)

        return request
    }

    /**
     Creates a URLRequest for the GPT-3.5 Turbo chat model.

     - Parameters:
     - messages: An array of dictionaries with a `role` and `content` key.
     Each dictionary represents a message in the conversation.
     The `role` can be either "user" or "assistant", and `content`
     contains the text of the message.
     - temperature: A double value that adjusts the randomness of the generated
     response. Higher values (e.g., 1.0) make the output more random,
     while lower values (e.g., 0.1) make it more deterministic.
     The default value is 0.7.
     - url: The API endpoint URL. The default value is the GPT-3.5 Turbo URL.

     - Returns: A URLRequest configured for the GPT-3.5 Turbo chat model.
     */
    static func gpt35TurboChatRequest(
        model: String = "gpt-3.5-turbo",
        messages: [[String: String]],
        temperature: Double = 0.7,
        url: URL = .gpt35Turbo()
    ) -> URLRequest {

        var request = URLRequest.standardOpenAiRequest(url: url)

        // Set the parameters for the API call
        let parameters: [String: Any] = [
            "model": model,
            "messages": messages,
            "temperature": temperature
        ]

        // Encode the parameters as JSON
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)

        return request
    }


    /// Standard open ai request
    /// - Parameters:
    ///   - url: url to use
    ///   - httpMethod: default = post
    ///   - apiKey: api key, default taken from Secrets.openAIKey
    /// - Returns: returns the URLRequest
    static func standardOpenAiRequest(
        url: URL,
        httpMethod: String = "POST",
        apiKey: String = Secrets.openAIKey
    ) -> Self {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}
