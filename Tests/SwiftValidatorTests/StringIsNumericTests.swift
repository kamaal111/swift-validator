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
        let rule = StringIsNumeric()

        #expect(rule.validate("0"))
        #expect(rule.validate("1"))
        #expect(rule.validate("123"))
        #expect(rule.validate("9999"))
    }

    @Test
    func `Validates negative integers`() async throws {
        let rule = StringIsNumeric()

        #expect(rule.validate("-1"))
        #expect(rule.validate("-123"))
        #expect(rule.validate("-9999"))
    }

    @Test
    func `Validates decimal numbers`() async throws {
        let rule = StringIsNumeric()

        #expect(rule.validate("0.5"))
        #expect(rule.validate("123.45"))
        #expect(rule.validate("-123.45"))
        #expect(rule.validate("0.001"))
    }

    @Test
    func `Validates numbers with leading decimal point`() async throws {
        let rule = StringIsNumeric()

        #expect(rule.validate(".5"))
        #expect(rule.validate(".123"))
    }

    @Test
    func `Validates scientific notation`() async throws {
        let rule = StringIsNumeric()

        #expect(rule.validate("1e10"))
        #expect(rule.validate("2.5e-3"))
        #expect(rule.validate("1E5"))
    }

    @Test
    func `Rejects empty string`() async throws {
        let rule = StringIsNumeric()

        #expect(!rule.validate(""))
    }

    @Test
    func `Rejects strings with letters`() async throws {
        let rule = StringIsNumeric()

        #expect(!rule.validate("abc"))
        #expect(!rule.validate("123abc"))
        #expect(!rule.validate("abc123"))
        #expect(!rule.validate("12a34"))
    }

    @Test
    func `Rejects strings with special characters`() async throws {
        let rule = StringIsNumeric()

        #expect(!rule.validate("123!"))
        #expect(!rule.validate("@123"))
        #expect(!rule.validate("12#34"))
        #expect(!rule.validate("$100"))
    }

    @Test
    func `Rejects strings with spaces`() async throws {
        let rule = StringIsNumeric()

        #expect(!rule.validate(" 123"))
        #expect(!rule.validate("123 "))
        #expect(!rule.validate("12 34"))
        #expect(!rule.validate(" "))
    }

    @Test
    func `Rejects strings with multiple decimal points`() async throws {
        let rule = StringIsNumeric()

        #expect(!rule.validate("1.2.3"))
        #expect(!rule.validate("12..34"))
    }

    @Test
    func `Rejects strings with multiple negative signs`() async throws {
        let rule = StringIsNumeric()

        #expect(!rule.validate("--123"))
        #expect(!rule.validate("-12-34"))
    }

    @Test
    func `Rejects non-numeric strings`() async throws {
        let rule = StringIsNumeric()

        #expect(!rule.validate("hello"))
        #expect(!rule.validate("test123"))
        #expect(!rule.validate("NaN"))
        #expect(!rule.validate("Infinity"))
    }

    @Test
    func `Validates zero variations`() async throws {
        let rule = StringIsNumeric()

        #expect(rule.validate("0"))
        #expect(rule.validate("0.0"))
        #expect(rule.validate("-0"))
    }

    @Test
    func `Has correct code property`() async throws {
        let rule = StringIsNumeric()
        #expect(rule.code == "numeric_string")
    }

    @Test
    func `Has correct message property`() async throws {
        let ruleWithoutMessage = StringIsNumeric()
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

    // MARK: - Comparison Operator Tests

    @Test
    func `Validates greater than comparison`() async throws {
        let comparison = StringIsNumeric.Comparison(op: .greaterThan, value: 10)
        let options = StringIsNumeric.Options(comparison: comparison)
        let rule = StringIsNumeric(options: options)

        #expect(rule.validate("11"))
        #expect(rule.validate("100"))
        #expect(rule.validate("10.1"))
        #expect(!rule.validate("10"))
        #expect(!rule.validate("9"))
        #expect(!rule.validate("0"))
        #expect(!rule.validate("-5"))
    }

    @Test
    func `Validates greater than or equal to comparison`() async throws {
        let comparison = StringIsNumeric.Comparison(op: .greaterThanOrEqualTo, value: 10)
        let options = StringIsNumeric.Options(comparison: comparison)
        let rule = StringIsNumeric(options: options)

        #expect(rule.validate("10"))
        #expect(rule.validate("11"))
        #expect(rule.validate("100"))
        #expect(rule.validate("10.0"))
        #expect(!rule.validate("9"))
        #expect(!rule.validate("9.99"))
        #expect(!rule.validate("-5"))
    }

    @Test
    func `Validates less than comparison`() async throws {
        let comparison = StringIsNumeric.Comparison(op: .lessThan, value: 10)
        let options = StringIsNumeric.Options(comparison: comparison)
        let rule = StringIsNumeric(options: options)

        #expect(rule.validate("9"))
        #expect(rule.validate("0"))
        #expect(rule.validate("-5"))
        #expect(rule.validate("9.99"))
        #expect(!rule.validate("10"))
        #expect(!rule.validate("11"))
        #expect(!rule.validate("100"))
    }

    @Test
    func `Validates less than or equal to comparison`() async throws {
        let comparison = StringIsNumeric.Comparison(op: .lessThanOrEqualTo, value: 10)
        let options = StringIsNumeric.Options(comparison: comparison)
        let rule = StringIsNumeric(options: options)

        #expect(rule.validate("10"))
        #expect(rule.validate("9"))
        #expect(rule.validate("0"))
        #expect(rule.validate("-5"))
        #expect(rule.validate("10.0"))
        #expect(!rule.validate("11"))
        #expect(!rule.validate("10.1"))
        #expect(!rule.validate("100"))
    }

    @Test
    func `Validates comparison with negative values`() async throws {
        let comparison = StringIsNumeric.Comparison(op: .greaterThan, value: -5)
        let options = StringIsNumeric.Options(comparison: comparison)
        let rule = StringIsNumeric(options: options)

        #expect(rule.validate("0"))
        #expect(rule.validate("-4"))
        #expect(rule.validate("10"))
        #expect(!rule.validate("-5"))
        #expect(!rule.validate("-6"))
        #expect(!rule.validate("-100"))
    }

    @Test
    func `Validates comparison with decimal values`() async throws {
        let comparison = StringIsNumeric.Comparison(op: .greaterThanOrEqualTo, value: 5.5)
        let options = StringIsNumeric.Options(comparison: comparison)
        let rule = StringIsNumeric(options: options)

        #expect(rule.validate("5.5"))
        #expect(rule.validate("6"))
        #expect(rule.validate("10.5"))
        #expect(!rule.validate("5"))
        #expect(!rule.validate("5.4"))
        #expect(!rule.validate("0"))
    }

    @Test
    func `Validates comparison with zero`() async throws {
        let gtComparison = StringIsNumeric.Comparison(op: .greaterThan, value: 0)
        let gtOptions = StringIsNumeric.Options(comparison: gtComparison)
        let gtRule = StringIsNumeric(options: gtOptions)

        #expect(gtRule.validate("1"))
        #expect(gtRule.validate("0.1"))
        #expect(!gtRule.validate("0"))
        #expect(!gtRule.validate("-1"))

        let ltComparison = StringIsNumeric.Comparison(op: .lessThan, value: 0)
        let ltOptions = StringIsNumeric.Options(comparison: ltComparison)
        let ltRule = StringIsNumeric(options: ltOptions)

        #expect(ltRule.validate("-1"))
        #expect(ltRule.validate("-0.1"))
        #expect(!ltRule.validate("0"))
        #expect(!ltRule.validate("1"))
    }

    @Test
    func `Validates options are optional`() async throws {
        let rule = StringIsNumeric()

        #expect(rule.validate("123"))
        #expect(rule.validate("-456"))
        #expect(rule.validate("0.5"))
    }

    @Test
    func `Rejects non-numeric strings with comparison options`() async throws {
        let comparison = StringIsNumeric.Comparison(op: .greaterThan, value: 10)
        let options = StringIsNumeric.Options(comparison: comparison)
        let rule = StringIsNumeric(options: options)

        #expect(!rule.validate("abc"))
        #expect(!rule.validate("12abc"))
        #expect(!rule.validate(""))
        #expect(!rule.validate(" 15"))
    }

    @Test
    func `Validates comparison with scientific notation`() async throws {
        let comparison = StringIsNumeric.Comparison(op: .greaterThan, value: 1000)
        let options = StringIsNumeric.Options(comparison: comparison)
        let rule = StringIsNumeric(options: options)

        #expect(rule.validate("1e4"))
        #expect(rule.validate("2e3"))
        #expect(!rule.validate("1e2"))
        #expect(!rule.validate("5e2"))
    }

    @Test
    func `Validates comparison with custom locale`() async throws {
        let germanLocale = Locale(identifier: "de_DE")
        let comparison = StringIsNumeric.Comparison(op: .greaterThanOrEqualTo, value: 10.5)
        let options = StringIsNumeric.Options(comparison: comparison)
        let rule = StringIsNumeric(locale: germanLocale, options: options)

        #expect(rule.validate("10,5"))
        #expect(rule.validate("11"))
        #expect(rule.validate("15,75"))
        #expect(!rule.validate("10"))
        #expect(!rule.validate("10,4"))
    }
}
