//
//  ValidateIsSameValueTests.swift
//  swift-validator
//
//  Created by Kamaal M Farah on 02/11/2025.
//

import Testing

@testable import SwiftValidator

struct ValidateIsSameValueTests {
    @Test
    func `Validates integer values are equal`() async throws {
        let rule = ValidateIsSameValue(value: 42)

        #expect(rule.validate(42))
        #expect(!rule.validate(41))
        #expect(!rule.validate(43))
    }

    @Test
    func `Validates string values are equal`() async throws {
        let rule = ValidateIsSameValue(value: "hello")

        #expect(rule.validate("hello"))
        #expect(!rule.validate("Hello"))
        #expect(!rule.validate("world"))
        #expect(!rule.validate(""))
    }

    @Test
    func `Validates boolean values are equal`() async throws {
        let trueRule = ValidateIsSameValue(value: true)
        let falseRule = ValidateIsSameValue(value: false)

        #expect(trueRule.validate(true))
        #expect(!trueRule.validate(false))

        #expect(falseRule.validate(false))
        #expect(!falseRule.validate(true))
    }

    @Test
    func `Validates double values are equal`() async throws {
        let rule = ValidateIsSameValue(value: 3.14)

        #expect(rule.validate(3.14))
        #expect(!rule.validate(3.15))
        #expect(!rule.validate(0.0))
    }

    @Test
    func `Validates array values are equal`() async throws {
        let rule = ValidateIsSameValue(value: [1, 2, 3])

        #expect(rule.validate([1, 2, 3]))
        #expect(!rule.validate([1, 2]))
        #expect(!rule.validate([1, 2, 3, 4]))
        #expect(!rule.validate([3, 2, 1]))
    }

    @Test
    func `Has correct code property`() async throws {
        let rule = ValidateIsSameValue(value: "test")
        #expect(rule.code == "same_value")
    }

    @Test
    func `Has correct value property`() async throws {
        let rule = ValidateIsSameValue(value: 100)
        #expect(rule.value == 100)
    }

    @Test
    func `Has correct message property`() async throws {
        let ruleWithoutMessage = ValidateIsSameValue(value: 42)
        #expect(ruleWithoutMessage.message == nil)

        let ruleWithMessage = ValidateIsSameValue(value: 42, message: "Values must match")
        #expect(ruleWithMessage.message == "Values must match")
    }

    @Test
    func `Checks equality of validators`() async throws {
        let rule1 = ValidateIsSameValue(value: 42, message: "Error")
        let rule2 = ValidateIsSameValue(value: 42, message: "Error")
        let rule3 = ValidateIsSameValue(value: 43, message: "Error")
        let rule4 = ValidateIsSameValue(value: 42, message: "Different")
        let rule5 = ValidateIsSameValue(value: 42)

        #expect(rule1 == rule2)
        #expect(rule1 != rule3)
        #expect(rule1 != rule4)
        #expect(rule1 != rule5)
    }
}
