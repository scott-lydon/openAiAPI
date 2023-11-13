//
//  URL.swift
//  
//
//  Created by Scott Lydon on 11/12/23.
//

import Foundation

extension URL {

    static func davinci(version: Int = 1) -> URL {
        URL(string: "https://api.openai.com/v\(version)/engines/davinci/completions")!
    }

    static func gpt35Turbo(version: Int = 1) -> URL {
         URL(string: "https://api.openai.com/v\(version)/chat/completions")!
     }

    static func models(version: Int = 1) -> URL {
        URL(string: "https://api.openai.com/v\(version)/models")!
    }
}
