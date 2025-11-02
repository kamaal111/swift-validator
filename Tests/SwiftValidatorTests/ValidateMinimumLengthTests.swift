//
//  ValidateMinimumLengthTests.swift
//  swift-validator
//
//  Created by Kamaal M Farah on 02/11/2025.
//

import Testing

@testable import SwiftValidator

struct ValidateMinimumLengthTests {
    @Test
    func `Validates array meeting minimum length`() async throws {
        let rule = ValidateMinimumLength<[Int]>(length: 3, message: nil)

        #expect(rule.validate([1, 2, 3]))
        #expect(rule.validate([1, 2, 3, 4, 5]))
        #expect(!rule.validate([1, 2]))
        #expect(!rule.validate([]))
    }

    @Test
    func `Validates array exactly at minimum length`() async throws {
        let rule = ValidateMinimumLength<[String]>(length: 2, message: nil)

        #expect(rule.validate(["a", "b"]))
        #expect(rule.validate(["a", "b", "c"]))
        #expect(!rule.validate(["a"]))
    }

    @Test
    func `Validates dictionary meeting minimum length`() async throws {
        let rule = ValidateMinimumLength<[String: Int]>(length: 2, message: nil)

        #expect(rule.validate(["a": 1, "b": 2]))
        #expect(rule.validate(["a": 1, "b": 2, "c": 3]))
        #expect(!rule.validate(["a": 1]))
        #expect(!rule.validate([:]))
    }

    @Test
    func `Validates set meeting minimum length`() async throws {
        let rule = ValidateMinimumLength<Set<String>>(length: 3, message: nil)

        #expect(rule.validate(["a", "b", "c"]))
        #expect(rule.validate(["a", "b", "c", "d"]))
        #expect(!rule.validate(["a", "b"]))
        #expect(!rule.validate([]))
    }

    @Test
    func `Validates string meeting minimum length`() async throws {
        let rule = ValidateMinimumLength<String>(length: 5, message: nil)

        #expect(rule.validate("hello"))
        #expect(rule.validate("hello world"))
        #expect(!rule.validate("hi"))
        #expect(!rule.validate(""))
    }

    @Test
    func `Validates empty collection when minimum is zero`() async throws {
        let arrayRule = ValidateMinimumLength<[Int]>(length: 0, message: nil)
        let dictRule = ValidateMinimumLength<[String: Int]>(length: 0, message: nil)
        let setRule = ValidateMinimumLength<Set<String>>(length: 0, message: nil)

        #expect(arrayRule.validate([]))
        #expect(dictRule.validate([:]))
        #expect(setRule.validate([]))
    }

    @Test
    func `Validates large collections`() async throws {
        let rule = ValidateMinimumLength<[Int]>(length: 100, message: nil)
        let largeArray = Array(1...100)
        let veryLargeArray = Array(1...200)

        #expect(rule.validate(largeArray))
        #expect(rule.validate(veryLargeArray))
        #expect(!rule.validate(Array(1...99)))
    }

    @Test
    func `Has correct code property`() async throws {
        let rule = ValidateMinimumLength<[Int]>(length: 5, message: nil)
        #expect(rule.code == "minimum_length")
    }

    @Test
    func `Has correct length property`() async throws {
        let rule = ValidateMinimumLength<[String]>(length: 10, message: nil)
        #expect(rule.length == 10)
    }

    @Test
    func `Has correct message property`() async throws {
        let ruleWithoutMessage = ValidateMinimumLength<[Int]>(length: 5, message: nil)
        #expect(ruleWithoutMessage.message == nil)

        let ruleWithMessage = ValidateMinimumLength<[Int]>(length: 5, message: "Too few items")
        #expect(ruleWithMessage.message == "Too few items")
    }

    @Test
    func `Checks equality of validators`() async throws {
        let rule1 = ValidateMinimumLength<[Int]>(length: 5, message: "Error")
        let rule2 = ValidateMinimumLength<[Int]>(length: 5, message: "Error")
        let rule3 = ValidateMinimumLength<[Int]>(length: 10, message: "Error")
        let rule4 = ValidateMinimumLength<[Int]>(length: 5, message: "Different")
        let rule5 = ValidateMinimumLength<[Int]>(length: 5, message: nil)

        #expect(rule1 == rule2)
        #expect(rule1 != rule3)
        #expect(rule1 != rule4)
        #expect(rule1 != rule5)
    }
}
