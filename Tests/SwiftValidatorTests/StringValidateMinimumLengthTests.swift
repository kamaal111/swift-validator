//
//  StringValidateMinimumLengthTests.swift
//  swift-validator
//
//  Created by Kamaal M Farah on 02/11/2025.
//

import Testing

@testable import SwiftValidator

struct StringValidateMinimumLengthTests {
    @Test
    func `Validates strings meeting minimum length`() async throws {
        let rule = StringValidateMinimumLength(length: 5, message: nil)

        #expect(rule.validate("hello"))
        #expect(rule.validate("hello world"))
        #expect(rule.validate("12345"))
    }

    @Test
    func `Validates strings exactly at minimum length`() async throws {
        let rule = StringValidateMinimumLength(length: 3, message: nil)

        #expect(rule.validate("abc"))
        #expect(rule.validate("123"))
    }

    @Test
    func `Rejects strings below minimum length`() async throws {
        let rule = StringValidateMinimumLength(length: 5, message: nil)

        #expect(!rule.validate("hi"))
        #expect(!rule.validate("test"))
        #expect(!rule.validate("1234"))
    }

    @Test
    func `Rejects empty string when minimum is positive`() async throws {
        let rule = StringValidateMinimumLength(length: 1, message: nil)

        #expect(!rule.validate(""))
    }

    @Test
    func `Validates empty string when minimum is zero`() async throws {
        let rule = StringValidateMinimumLength(length: 0, message: nil)

        #expect(rule.validate(""))
        #expect(rule.validate("a"))
        #expect(rule.validate("hello"))
    }

    @Test
    func `Validates strings with unicode characters`() async throws {
        let rule = StringValidateMinimumLength(length: 3, message: nil)

        #expect(rule.validate("café"))
        #expect(rule.validate("你好世界"))
        #expect(rule.validate("🎉🎊🎈"))
    }

    @Test
    func `Validates strings with spaces`() async throws {
        let rule = StringValidateMinimumLength(length: 5, message: nil)

        #expect(rule.validate("a b c"))
        #expect(rule.validate("     "))
        #expect(!rule.validate("a b"))
    }

    @Test
    func `Validates long strings`() async throws {
        let rule = StringValidateMinimumLength(length: 100, message: nil)
        let longString = String(repeating: "a", count: 100)
        let veryLongString = String(repeating: "b", count: 200)

        #expect(rule.validate(longString))
        #expect(rule.validate(veryLongString))
        #expect(!rule.validate(String(repeating: "c", count: 99)))
    }

    @Test
    func `Has correct code property`() async throws {
        let rule = StringValidateMinimumLength(length: 5, message: nil)
        #expect(rule.code == "minimum_length")
    }

    @Test
    func `Has correct length property`() async throws {
        let rule = StringValidateMinimumLength(length: 10, message: nil)
        #expect(rule.length == 10)
    }

    @Test
    func `Has correct message property`() async throws {
        let ruleWithoutMessage = StringValidateMinimumLength(length: 5, message: nil)
        #expect(ruleWithoutMessage.message == nil)

        let ruleWithMessage = StringValidateMinimumLength(length: 5, message: "Too short")
        #expect(ruleWithMessage.message == "Too short")
    }

    @Test
    func `Checks equality of validators`() async throws {
        let rule1 = StringValidateMinimumLength(length: 5, message: "Error")
        let rule2 = StringValidateMinimumLength(length: 5, message: "Error")
        let rule3 = StringValidateMinimumLength(length: 10, message: "Error")
        let rule4 = StringValidateMinimumLength(length: 5, message: "Different")
        let rule5 = StringValidateMinimumLength(length: 5, message: nil)

        #expect(rule1 == rule2)
        #expect(rule1 != rule3)
        #expect(rule1 != rule4)
        #expect(rule1 != rule5)
    }
}
