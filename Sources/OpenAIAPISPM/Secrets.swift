//
//  File.swift
//  
//
//  Created by Scott Lydon on 11/12/23.
//

import Foundation

public struct Secrets {
    /// Assign me first.
    public static var openAIKey = ""

    static func assertHasKey() {
        assert(
            openAIKey != "",
            """
            Attempted to define an open ai url before setting the api key.
            You can do so with: `Secrets.openAIKey = `
            """
        )
    }
}
