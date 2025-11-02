//
//  StringIsTheSameValueTests.swift
//  swift-validator
//
//  Created by Kamaal M Farah on 02/11/2025.
//

import Testing

@testable import SwiftValidator

struct StringIsTheSameValueTests {
    @Test
    func `Validates strings are equal`() async throws {
        let rule = StringIsTheSameValue(value: "password123")

        #expect(rule.validate("password123"))
        #expect(!rule.validate("Password123"))
        #expect(!rule.validate("password"))
        #expect(!rule.validate(""))
    }

    @Test
    func `Validates empty strings`() async throws {
        let rule = StringIsTheSameValue(value: "")

        #expect(rule.validate(""))
        #expect(!rule.validate(" "))
        #expect(!rule.validate("a"))
    }

    @Test
    func `Validates strings with special characters`() async throws {
        let rule = StringIsTheSameValue(value: "test@example.com")

        #expect(rule.validate("test@example.com"))
        #expect(!rule.validate("test@example.co"))
        #expect(!rule.validate("Test@example.com"))
    }

    @Test
    func `Validates strings with spaces`() async throws {
        let rule = StringIsTheSameValue(value: "hello world")

        #expect(rule.validate("hello world"))
        #expect(!rule.validate("hello  world"))
        #expect(!rule.validate("helloworld"))
    }

    @Test
    func `Validates strings with unicode characters`() async throws {
        let rule = StringIsTheSameValue(value: "café")

        #expect(rule.validate("café"))
        #expect(!rule.validate("cafe"))
        #expect(!rule.validate("Café"))
    }

    @Test
    func `Has correct code property`() async throws {
        let rule = StringIsTheSameValue(value: "test")
        #expect(rule.code == "same_value")
    }

    @Test
    func `Has correct value property`() async throws {
        let rule = StringIsTheSameValue(value: "myValue")
        #expect(rule.value == "myValue")
    }

    @Test
    func `Has correct message property`() async throws {
        let ruleWithoutMessage = StringIsTheSameValue(value: "test")
        #expect(ruleWithoutMessage.message == nil)

        let ruleWithMessage = StringIsTheSameValue(value: "test", message: "Strings must match")
        #expect(ruleWithMessage.message == "Strings must match")
    }

    @Test
    func `Checks equality of validators`() async throws {
        let rule1 = StringIsTheSameValue(value: "test", message: "Error")
        let rule2 = StringIsTheSameValue(value: "test", message: "Error")
        let rule3 = StringIsTheSameValue(value: "other", message: "Error")
        let rule4 = StringIsTheSameValue(value: "test", message: "Different")
        let rule5 = StringIsTheSameValue(value: "test")

        #expect(rule1 == rule2)
        #expect(rule1 != rule3)
        #expect(rule1 != rule4)
        #expect(rule1 != rule5)
    }
}
