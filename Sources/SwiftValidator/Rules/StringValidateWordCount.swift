//
//  StringValidateWordCount.swift
//  swift-validator
//
//  Created by Kamaal M Farah on 26/10/2025.
//

import Foundation

/// A validation rule that checks if a string contains an exact number of words.
///
/// This rule validates that a string contains exactly the specified number of words,
/// separated by single spaces. It also ensures:
/// - No leading or trailing whitespace
/// - No multiple consecutive spaces between words
/// - Words are separated by exactly one space
///
/// Example:
/// ```swift
/// let rule = StringValidateWordCount(wordCount: 3, message: "Must be 3 words")
/// rule.validate("hello world test")  // true
/// rule.validate("hello world")       // false (only 2 words)
/// rule.validate(" hello world test") // false (leading space)
/// rule.validate("hello  world test") // false (double space)
///
/// // Use with StringValidator
/// let validator = StringValidator(value: "one two three", validators: [rule])
/// print(validator.result.valid) // true
/// ```
public class StringValidateWordCount: StringValidatableRule {
    /// The unique identifier for this validation rule: `"word_count"`.
    public let code = "word_count"

    /// The exact number of words required in the string.
    public let wordCount: Int

    /// An optional custom error message to display when validation fails.
    public let message: String?

    /// Creates a new validation rule to check if a string contains an exact word count.
    ///
    /// - Parameters:
    ///   - wordCount: The exact number of words required. Must be at least 1.
    ///   - message: An optional custom error message to display when validation fails.
    ///              Defaults to `nil`.
    ///
    /// - Precondition: `wordCount` must be greater than or equal to 1.
    public init(wordCount: Int, message: String? = nil) {
        assert(wordCount >= 1)

        self.wordCount = wordCount
        self.message = message
    }

    /// Validates that the given string contains exactly the required number of words.
    ///
    /// The validation ensures:
    /// - The string has no leading or trailing whitespace
    /// - Words are separated by single spaces only (no multiple consecutive spaces)
    /// - The total word count matches the required count
    ///
    /// - Parameter value: The string to validate.
    /// - Returns: `true` if the string contains exactly `wordCount` words with proper spacing,
    ///            `false` otherwise.
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
