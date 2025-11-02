//
//  StringIsNumericTests.swift
//  swift-validator
//
//  Created by Kamaal M Farah on 02/11/2025.
//

import Foundation
import Testing

@testable import SwiftValidator

struct StringIsNumericTests {
    @Test
    func `Validates positive integers`() async throws {
        let rule = StringIsNumeric(message: nil)

        #expect(rule.validate("0"))
        #expect(rule.validate("1"))
        #expect(rule.validate("123"))
        #expect(rule.validate("9999"))
    }

    @Test
    func `Validates negative integers`() async throws {
        let rule = StringIsNumeric(message: nil)

        #expect(rule.validate("-1"))
        #expect(rule.validate("-123"))
        #expect(rule.validate("-9999"))
    }

    @Test
    func `Validates decimal numbers`() async throws {
        let rule = StringIsNumeric(message: nil)

        #expect(rule.validate("0.5"))
        #expect(rule.validate("123.45"))
        #expect(rule.validate("-123.45"))
        #expect(rule.validate("0.001"))
    }

    @Test
    func `Validates numbers with leading decimal point`() async throws {
        let rule = StringIsNumeric(message: nil)

        #expect(rule.validate(".5"))
        #expect(rule.validate(".123"))
    }

    @Test
    func `Validates scientific notation`() async throws {
        let rule = StringIsNumeric(message: nil)

        #expect(rule.validate("1e10"))
        #expect(rule.validate("2.5e-3"))
        #expect(rule.validate("1E5"))
    }

    @Test
    func `Rejects empty string`() async throws {
        let rule = StringIsNumeric(message: nil)

        #expect(!rule.validate(""))
    }

    @Test
    func `Rejects strings with letters`() async throws {
        let rule = StringIsNumeric(message: nil)

        #expect(!rule.validate("abc"))
        #expect(!rule.validate("123abc"))
        #expect(!rule.validate("abc123"))
        #expect(!rule.validate("12a34"))
    }

    @Test
    func `Rejects strings with special characters`() async throws {
        let rule = StringIsNumeric(message: nil)

        #expect(!rule.validate("123!"))
        #expect(!rule.validate("@123"))
        #expect(!rule.validate("12#34"))
        #expect(!rule.validate("$100"))
    }

    @Test
    func `Rejects strings with spaces`() async throws {
        let rule = StringIsNumeric(message: nil)

        #expect(!rule.validate(" 123"))
        #expect(!rule.validate("123 "))
        #expect(!rule.validate("12 34"))
        #expect(!rule.validate(" "))
    }

    @Test
    func `Rejects strings with multiple decimal points`() async throws {
        let rule = StringIsNumeric(message: nil)

        #expect(!rule.validate("1.2.3"))
        #expect(!rule.validate("12..34"))
    }

    @Test
    func `Rejects strings with multiple negative signs`() async throws {
        let rule = StringIsNumeric(message: nil)

        #expect(!rule.validate("--123"))
        #expect(!rule.validate("-12-34"))
    }

    @Test
    func `Rejects non-numeric strings`() async throws {
        let rule = StringIsNumeric(message: nil)

        #expect(!rule.validate("hello"))
        #expect(!rule.validate("test123"))
        #expect(!rule.validate("NaN"))
        #expect(!rule.validate("Infinity"))
    }

    @Test
    func `Validates zero variations`() async throws {
        let rule = StringIsNumeric(message: nil)

        #expect(rule.validate("0"))
        #expect(rule.validate("0.0"))
        #expect(rule.validate("-0"))
    }

    @Test
    func `Has correct code property`() async throws {
        let rule = StringIsNumeric(message: nil)
        #expect(rule.code == "numeric_string")
    }

    @Test
    func `Has correct message property`() async throws {
        let ruleWithoutMessage = StringIsNumeric(message: nil)
        #expect(ruleWithoutMessage.message == nil)

        let ruleWithMessage = StringIsNumeric(message: "Must be numeric")
        #expect(ruleWithMessage.message == "Must be numeric")
    }

    @Test
    func `Has default locale`() async throws {
        let rule = StringIsNumeric()
        #expect(rule.locale.identifier == "en_US_POSIX")
    }

    @Test
    func `Accepts custom locale`() async throws {
        let customLocale = Locale(identifier: "de_DE")
        let rule = StringIsNumeric(locale: customLocale)
        #expect(rule.locale.identifier == "de_DE")
    }

    @Test
    func `Validates numbers with custom locale decimal separator`() async throws {
        let germanLocale = Locale(identifier: "de_DE")
        let rule = StringIsNumeric(locale: germanLocale)

        #expect(rule.validate("123,45"))
        #expect(rule.validate("1,5"))
    }
}
