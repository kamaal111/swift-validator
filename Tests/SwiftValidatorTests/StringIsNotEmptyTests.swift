//
//  StringIsNotEmptyTests.swift
//  swift-validator
//
//  Created by Kamaal M Farah on 02/11/2025.
//

import Testing

@testable import SwiftValidator

struct StringIsNotEmptyTests {
    @Test
    func `Validates non-empty strings`() async throws {
        let rule = StringIsNotEmpty()

        #expect(rule.validate("hello"))
        #expect(rule.validate("a"))
        #expect(rule.validate("test string"))
        #expect(rule.validate("123"))
    }

    @Test
    func `Rejects empty string`() async throws {
        let rule = StringIsNotEmpty()

        #expect(!rule.validate(""))
    }

    @Test
    func `Validates string with only spaces`() async throws {
        let rule = StringIsNotEmpty()

        // Spaces count as content
        #expect(rule.validate(" "))
        #expect(rule.validate("   "))
        #expect(rule.validate("\t"))
        #expect(rule.validate("\n"))
    }

    @Test
    func `Validates strings with special characters`() async throws {
        let rule = StringIsNotEmpty()

        #expect(rule.validate("!@#$%"))
        #expect(rule.validate("test@example.com"))
        #expect(rule.validate("hello!"))
    }

    @Test
    func `Validates strings with unicode characters`() async throws {
        let rule = StringIsNotEmpty()

        #expect(rule.validate("café"))
        #expect(rule.validate("🎉"))
        #expect(rule.validate("你好"))
        #expect(rule.validate("مرحبا"))
    }

    @Test
    func `Validates strings with newlines and tabs`() async throws {
        let rule = StringIsNotEmpty()

        #expect(rule.validate("hello\nworld"))
        #expect(rule.validate("\thello"))
        #expect(rule.validate("test\r\n"))
    }

    @Test
    func `Validates long strings`() async throws {
        let rule = StringIsNotEmpty()
        let longString = String(repeating: "a", count: 10000)

        #expect(rule.validate(longString))
    }

    @Test
    func `Has correct code property`() async throws {
        let rule = StringIsNotEmpty()
        #expect(rule.code == "is_not_empty")
    }

    @Test
    func `Has correct message property`() async throws {
        let ruleWithoutMessage = StringIsNotEmpty()
        #expect(ruleWithoutMessage.message == nil)

        let ruleWithMessage = StringIsNotEmpty(message: "String cannot be empty")
        #expect(ruleWithMessage.message == "String cannot be empty")
    }

    @Test
    func `Checks equality of validators`() async throws {
        let rule1 = StringIsNotEmpty(message: "Error")
        let rule2 = StringIsNotEmpty(message: "Error")
        let rule3 = StringIsNotEmpty(message: "Different")
        let rule4 = StringIsNotEmpty()

        #expect(rule1 == rule2)
        #expect(rule1 != rule3)
        #expect(rule1 != rule4)
        #expect(rule3 != rule4)
    }

    @Test
    func `Validates string with single character`() async throws {
        let rule = StringIsNotEmpty()

        #expect(rule.validate("a"))
        #expect(rule.validate("1"))
        #expect(rule.validate("!"))
        #expect(rule.validate(" "))
    }

    @Test
    func `Validates string with mixed content`() async throws {
        let rule = StringIsNotEmpty()

        #expect(rule.validate("hello123"))
        #expect(rule.validate("test-string"))
        #expect(rule.validate("email@test.com"))
        #expect(rule.validate("Mixed Case String"))
    }

    @Test
    func `Works with StringValidator`() async throws {
        let notEmptyRule = StringIsNotEmpty(message: "String is required")

        let validValidator = StringValidator(value: "hello", validators: [notEmptyRule])
        #expect(validValidator.result.valid == true)
        #expect(validValidator.result.message == nil)

        let invalidValidator = StringValidator(value: "", validators: [notEmptyRule])
        #expect(invalidValidator.result.valid == false)
        #expect(invalidValidator.result.message == "String is required")
    }

    @Test
    func `Works with StringValidator and multiple rules`() async throws {
        let notEmptyRule = StringIsNotEmpty(message: "String is required")
        let minLengthRule = StringValidateMinimumLength(length: 5, message: "Too short")

        let validValidator = StringValidator(value: "hello world", validators: [notEmptyRule, minLengthRule])
        #expect(validValidator.result.valid == true)
        #expect(validValidator.result.message == nil)

        let emptyValidator = StringValidator(value: "", validators: [notEmptyRule, minLengthRule])
        #expect(emptyValidator.result.valid == false)
        #expect(emptyValidator.result.message == "String is required")

        let shortValidator = StringValidator(value: "hi", validators: [notEmptyRule, minLengthRule])
        #expect(shortValidator.result.valid == false)
        #expect(shortValidator.result.message == "Too short")
    }
}
