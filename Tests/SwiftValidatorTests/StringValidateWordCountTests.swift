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

    @Test("Validates string with exact word count")
    func testValidatesExactWordCount() {
        let validator = StringValidateWordCount(wordCount: 2, message: nil)

        #expect(validator.validate("hello world"))
        #expect(validator.validate("foo bar"))
        #expect(validator.validate("swift testing"))
    }

    @Test("Validates single word")
    func testValidatesSingleWord() {
        let validator = StringValidateWordCount(wordCount: 1, message: nil)

        #expect(validator.validate("hello"))
        #expect(validator.validate("world"))
        #expect(validator.validate("test"))
    }

    @Test("Validates multiple words")
    func testValidatesMultipleWords() {
        let validator = StringValidateWordCount(wordCount: 3, message: nil)

        #expect(validator.validate("one two three"))
        #expect(validator.validate("hello world again"))
    }

    @Test("Validates five words")
    func testValidatesFiveWords() {
        let validator = StringValidateWordCount(wordCount: 5, message: nil)

        #expect(validator.validate("this is a test string"))
        #expect(validator.validate("swift testing is very cool"))
    }

    // MARK: - Invalid Cases - Wrong Word Count

    @Test("Rejects string with fewer words")
    func testRejectsFewerWords() {
        let validator = StringValidateWordCount(wordCount: 3, message: nil)

        #expect(!validator.validate("hello world"))
        #expect(!validator.validate("one"))
    }

    @Test("Rejects string with more words")
    func testRejectsMoreWords() {
        let validator = StringValidateWordCount(wordCount: 2, message: nil)

        #expect(!validator.validate("hello world test"))
        #expect(!validator.validate("one two three four"))
    }

    @Test("Rejects empty string when word count is positive")
    func testRejectsEmptyString() {
        let validator = StringValidateWordCount(wordCount: 2, message: nil)

        #expect(!validator.validate(""))
    }

    // MARK: - Invalid Cases - Leading/Trailing Spaces

    @Test("Rejects string with leading space")
    func testRejectsLeadingSpace() {
        let validator = StringValidateWordCount(wordCount: 2, message: nil)

        #expect(!validator.validate(" hello world"))
        #expect(!validator.validate("  hello world"))
    }

    @Test("Rejects string with trailing space")
    func testRejectsTrailingSpace() {
        let validator = StringValidateWordCount(wordCount: 2, message: nil)

        #expect(!validator.validate("hello world "))
        #expect(!validator.validate("hello world  "))
    }

    @Test("Rejects string with both leading and trailing spaces")
    func testRejectsLeadingAndTrailingSpaces() {
        let validator = StringValidateWordCount(wordCount: 2, message: nil)

        #expect(!validator.validate(" hello world "))
        #expect(!validator.validate("  hello world  "))
    }

    // MARK: - Invalid Cases - Multiple Spaces

    @Test("Rejects string with double spaces")
    func testRejectsDoubleSpaces() {
        let validator = StringValidateWordCount(wordCount: 2, message: nil)

        #expect(!validator.validate("hello  world"))
        #expect(!validator.validate("hello   world"))
    }

    @Test("Rejects string with multiple spaces between words")
    func testRejectsMultipleSpacesBetweenWords() {
        let validator = StringValidateWordCount(wordCount: 3, message: nil)

        #expect(!validator.validate("one  two three"))
        #expect(!validator.validate("one two  three"))
        #expect(!validator.validate("one  two  three"))
    }

    // MARK: - Edge Cases

    @Test("Rejects string with only spaces")
    func testRejectsOnlySpaces() {
        let validator = StringValidateWordCount(wordCount: 2, message: nil)

        #expect(!validator.validate("   "))
        #expect(!validator.validate(" "))
    }

    @Test("Validates words with special characters")
    func testValidatesWordsWithSpecialCharacters() {
        let validator = StringValidateWordCount(wordCount: 2, message: nil)

        #expect(validator.validate("hello! world?"))
        #expect(validator.validate("test@example.com another"))
        #expect(validator.validate("123 456"))
    }

    // MARK: - Equality Tests

    @Test("Checks equality of validators")
    func testValidatorEquality() {
        let validator1 = StringValidateWordCount(wordCount: 2, message: nil)
        let validator2 = StringValidateWordCount(wordCount: 2, message: nil)
        let validator3 = StringValidateWordCount(wordCount: 3, message: nil)
        let validator4 = StringValidateWordCount(wordCount: 2, message: "error")

        #expect(validator1 == validator2)
        #expect(validator1 != validator3)
        #expect(validator1 != validator4)
    }

    // MARK: - Properties Tests

    @Test("Has correct code property")
    func testCodeProperty() {
        let validator = StringValidateWordCount(wordCount: 2, message: nil)

        #expect(validator.code == "word_count")
    }

    @Test("Has correct wordCount property")
    func testWordCountProperty() {
        let validator = StringValidateWordCount(wordCount: 5, message: "custom message")

        #expect(validator.wordCount == 5)
    }

    @Test("Has correct message property")
    func testMessageProperty() {
        let validatorWithoutMessage = StringValidateWordCount(wordCount: 2, message: nil)
        let validatorWithMessage = StringValidateWordCount(wordCount: 2, message: "custom error")

        #expect(validatorWithoutMessage.message == nil)
        #expect(validatorWithMessage.message == "custom error")
    }
}
