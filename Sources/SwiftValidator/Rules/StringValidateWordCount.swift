//
//  StringValidateWordCount.swift
//  swift-validator
//
//  Created by Kamaal M Farah on 26/10/2025.
//

import Foundation

public class StringValidateWordCount: StringValidatableRule {
    public let code = "word_count"
    public let wordCount: Int
    public let message: String?

    public init(wordCount: Int, message: String?) {
        assert(wordCount >= 1)

        self.wordCount = wordCount
        self.message = message
    }

    public func validate(_ value: String) -> Bool {
        guard wordCount >= 1 else { return false }

        let trimmedValue = value.trimmingCharacters(in: .whitespaces)
        // If the string has leading or trailing spaces, it's invalid
        guard trimmedValue == value else { return false }

        let words = trimmedValue.split(separator: " ", omittingEmptySubsequences: true)
        // Check if the word count matches
        guard words.count == wordCount else { return false }

        let reconstructed = words.joined(separator: " ")

        return reconstructed == value
    }
}

extension StringValidateWordCount: Equatable {
    public static func == (lhs: StringValidateWordCount, rhs: StringValidateWordCount) -> Bool {
        lhs.wordCount == rhs.wordCount && lhs.message == rhs.message
    }
}
