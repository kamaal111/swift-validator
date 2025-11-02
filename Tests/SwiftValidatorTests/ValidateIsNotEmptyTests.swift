//
//  ValidateIsNotEmptyTests.swift
//  swift-validator
//
//  Created by Kamaal M Farah on 02/11/2025.
//

import Testing

@testable import SwiftValidator

struct ValidateIsNotEmptyTests {
    @Test
    func `Validates string is not empty`() async throws {
        let rule = ValidateIsNotEmpty<String>()

        #expect(rule.validate("Hello"))
        #expect(rule.validate("a"))
        #expect(!rule.validate(""))
    }

    @Test
    func `Validates array is not empty`() async throws {
        let rule = ValidateIsNotEmpty<[Int]>()

        #expect(rule.validate([1, 2, 3]))
        #expect(rule.validate([1]))
        #expect(!rule.validate([]))
    }

    @Test
    func `Validates dictionary is not empty`() async throws {
        let rule = ValidateIsNotEmpty<[String: Int]>()

        #expect(rule.validate(["key": 1]))
        #expect(rule.validate(["a": 1, "b": 2]))
        #expect(!rule.validate([:]))
    }

    @Test
    func `Validates set is not empty`() async throws {
        let rule = ValidateIsNotEmpty<Set<String>>()

        #expect(rule.validate(["hello"]))
        #expect(rule.validate(["a", "b"]))
        #expect(!rule.validate([]))
    }

    @Test
    func `Has correct code property`() async throws {
        let rule = ValidateIsNotEmpty<String>()
        #expect(rule.code == "is_not_empty")
    }

    @Test
    func `Has correct message property`() async throws {
        let ruleWithoutMessage = ValidateIsNotEmpty<String>()
        #expect(ruleWithoutMessage.message == nil)

        let ruleWithMessage = ValidateIsNotEmpty<String>(message: "Cannot be empty")
        #expect(ruleWithMessage.message == "Cannot be empty")
    }

    @Test
    func `Checks equality of validators`() async throws {
        let rule1 = ValidateIsNotEmpty<String>(message: "Error")
        let rule2 = ValidateIsNotEmpty<String>(message: "Error")
        let rule3 = ValidateIsNotEmpty<String>(message: "Different")
        let rule4 = ValidateIsNotEmpty<String>()

        #expect(rule1 == rule2)
        #expect(rule1 != rule3)
        #expect(rule1 != rule4)
    }
}
