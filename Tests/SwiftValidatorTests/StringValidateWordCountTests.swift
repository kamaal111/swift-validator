//
//  StringValidateWordCountTests.swift
//  swift-validator
//
//  Created by Kamaal M Farah on 26/10/2025.
//

import SwiftValidator
import Testing

@Suite("StringValidateWordCount Tests")
struct StringValidateWordCountTests {

    // MARK: - Valid Cases

    @Test
    func `Validates string with exact word count`() {
        let validator = StringValidateWordCount(wordCount: 2, message: nil)

        #expect(validator.validate("hello world"))
        #expect(validator.validate("foo bar"))
        #expect(validator.validate("swift testing"))
    }

    @Test
    func `Validates single word`() {
        let validator = StringValidateWordCount(wordCount: 1, message: nil)

        #expect(validator.validate("hello"))
        #expect(validator.validate("world"))
        #expect(validator.validate("test"))
    }

    @Test
    func `Validates multiple words`() {
        let validator = StringValidateWordCount(wordCount: 3, message: nil)

        #expect(validator.validate("one two three"))
        #expect(validator.validate("hello world again"))
    }

    @Test
    func `Validates five words`() {
        let validator = StringValidateWordCount(wordCount: 5, message: nil)

        #expect(validator.validate("this is a test string"))
        #expect(validator.validate("swift testing is very cool"))
    }

    // MARK: - Invalid Cases - Wrong Word Count

    @Test
    func `Rejects string with fewer words`() {
        let validator = StringValidateWordCount(wordCount: 3, message: nil)

        #expect(!validator.validate("hello world"))
        #expect(!validator.validate("one"))
    }

    @Test
    func `Rejects string with more words`() {
        let validator = StringValidateWordCount(wordCount: 2, message: nil)

        #expect(!validator.validate("hello world test"))
        #expect(!validator.validate("one two three four"))
    }

    @Test
    func `Rejects empty string when word count is positive`() {
        let validator = StringValidateWordCount(wordCount: 2, message: nil)

        #expect(!validator.validate(""))
    }

    // MARK: - Invalid Cases - Leading/Trailing Spaces

    @Test
    func `Rejects string with leading space`() {
        let validator = StringValidateWordCount(wordCount: 2, message: nil)

        #expect(!validator.validate(" hello world"))
        #expect(!validator.validate("  hello world"))
    }

    @Test
    func `Rejects string with trailing space`() {
        let validator = StringValidateWordCount(wordCount: 2, message: nil)

        #expect(!validator.validate("hello world "))
        #expect(!validator.validate("hello world  "))
    }

    @Test
    func `Rejects string with both leading and trailing spaces`() {
        let validator = StringValidateWordCount(wordCount: 2, message: nil)

        #expect(!validator.validate(" hello world "))
        #expect(!validator.validate("  hello world  "))
    }

    // MARK: - Invalid Cases - Multiple Spaces

    @Test
    func `Rejects string with double spaces`() {
        let validator = StringValidateWordCount(wordCount: 2, message: nil)

        #expect(!validator.validate("hello  world"))
        #expect(!validator.validate("hello   world"))
    }

    @Test
    func `Rejects string with multiple spaces between words`() {
        let validator = StringValidateWordCount(wordCount: 3, message: nil)

        #expect(!validator.validate("one  two three"))
        #expect(!validator.validate("one two  three"))
        #expect(!validator.validate("one  two  three"))
    }

    // MARK: - Edge Cases

    @Test
    func `Rejects string with only spaces`() {
        let validator = StringValidateWordCount(wordCount: 2, message: nil)

        #expect(!validator.validate("   "))
        #expect(!validator.validate(" "))
    }

    @Test
    func `Validates words with special characters`() {
        let validator = StringValidateWordCount(wordCount: 2, message: nil)

        #expect(validator.validate("hello! world?"))
        #expect(validator.validate("test@example.com another"))
        #expect(validator.validate("123 456"))
    }

    // MARK: - Equality Tests

    @Test
    func `Checks equality of validators`() {
        let validator1 = StringValidateWordCount(wordCount: 2, message: nil)
        let validator2 = StringValidateWordCount(wordCount: 2, message: nil)
        let validator3 = StringValidateWordCount(wordCount: 3, message: nil)
        let validator4 = StringValidateWordCount(wordCount: 2, message: "error")

        #expect(validator1 == validator2)
        #expect(validator1 != validator3)
        #expect(validator1 != validator4)
    }

    // MARK: - Properties Tests

    @Test
    func `Has correct code property`() {
        let validator = StringValidateWordCount(wordCount: 2, message: nil)

        #expect(validator.code == "word_count")
    }

    @Test
    func `Has correct wordCount property`() {
        let validator = StringValidateWordCount(wordCount: 5, message: "custom message")

        #expect(validator.wordCount == 5)
    }

    @Test
    func `Has correct message property`() {
        let validatorWithoutMessage = StringValidateWordCount(wordCount: 2, message: nil)
        let validatorWithMessage = StringValidateWordCount(wordCount: 2, message: "custom error")

        #expect(validatorWithoutMessage.message == nil)
        #expect(validatorWithMessage.message == "custom error")
    }
}
