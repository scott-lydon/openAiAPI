//
//  File.swift
//  
//
//  Created by Scott Lydon on 11/12/23.
//

import Foundation


// Extension to create messages for GPT-3.5 Turbo chat requests
extension Array where Element == [String: String] {
    static func buildUserMessage(content: String) -> [[String: String]] {
        [["role": "user", "content": content]]
    }

    static func buildAssistantMessage(content: String) -> [[String: String]] {
        [["role": "assistant", "content": content]]
    }
}
