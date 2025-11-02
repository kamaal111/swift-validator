//
//  StringIsEmailTests.swift
//  swift-validator
//
//  Created by Kamaal M Farah on 02/11/2025.
//

import Testing

@testable import SwiftValidator

struct StringIsEmailTests {
    @Test
    func `Validates standard email addresses`() async throws {
        let rule = StringIsEmail(message: nil)

        #expect(rule.validate("test@example.com"))
        #expect(rule.validate("user@domain.co.uk"))
        #expect(rule.validate("name.surname@company.org"))
        #expect(rule.validate("email@subdomain.example.com"))
    }

    @Test
    func `Validates emails with plus sign`() async throws {
        let rule = StringIsEmail(message: nil)

        #expect(rule.validate("user+tag@example.com"))
        #expect(rule.validate("test+spam@domain.org"))
    }

    @Test
    func `Validates emails with numbers`() async throws {
        let rule = StringIsEmail(message: nil)

        #expect(rule.validate("user123@example.com"))
        #expect(rule.validate("123test@domain.com"))
        #expect(rule.validate("test@example123.com"))
    }

    @Test
    func `Validates emails with hyphens and underscores`() async throws {
        let rule = StringIsEmail(message: nil)

        #expect(rule.validate("user-name@example.com"))
        #expect(rule.validate("user_name@example.com"))
        #expect(rule.validate("test@my-domain.com"))
    }

    @Test
    func `Validates case insensitive emails`() async throws {
        let rule = StringIsEmail(message: nil)

        #expect(rule.validate("TEST@EXAMPLE.COM"))
        #expect(rule.validate("Test@Example.Com"))
        #expect(rule.validate("TeSt@eXaMpLe.CoM"))
    }

    @Test
    func `Rejects emails without at sign`() async throws {
        let rule = StringIsEmail(message: nil)

        #expect(!rule.validate("testexample.com"))
        #expect(!rule.validate("user.domain.com"))
    }

    @Test
    func `Rejects emails without domain`() async throws {
        let rule = StringIsEmail(message: nil)

        #expect(!rule.validate("test@"))
        #expect(!rule.validate("user@.com"))
    }

    @Test
    func `Rejects emails without username`() async throws {
        let rule = StringIsEmail(message: nil)

        #expect(!rule.validate("@example.com"))
        #expect(!rule.validate("@domain.org"))
    }

    @Test
    func `Rejects emails with spaces`() async throws {
        let rule = StringIsEmail(message: nil)

        #expect(!rule.validate("test @example.com"))
        #expect(!rule.validate("test@ example.com"))
        #expect(!rule.validate("test@example .com"))
        #expect(!rule.validate(" test@example.com"))
        #expect(!rule.validate("test@example.com "))
    }

    @Test
    func `Rejects emails with double dots`() async throws {
        let rule = StringIsEmail(message: nil)

        #expect(!rule.validate("test..user@example.com"))
        #expect(!rule.validate("test@example..com"))
    }

    @Test
    func `Rejects emails starting with dot`() async throws {
        let rule = StringIsEmail(message: nil)

        #expect(!rule.validate(".test@example.com"))
        #expect(!rule.validate("test@.example.com"))
    }

    @Test
    func `Rejects emails with invalid characters`() async throws {
        let rule = StringIsEmail(message: nil)

        #expect(!rule.validate("test@exam ple.com"))
        #expect(!rule.validate("test#user@example.com"))
        #expect(!rule.validate("test@example!.com"))
    }

    @Test
    func `Rejects empty string`() async throws {
        let rule = StringIsEmail(message: nil)

        #expect(!rule.validate(""))
    }

    @Test
    func `Rejects emails without TLD`() async throws {
        let rule = StringIsEmail(message: nil)

        #expect(!rule.validate("test@example"))
        #expect(!rule.validate("user@domain"))
    }

    @Test
    func `Rejects emails with single character TLD`() async throws {
        let rule = StringIsEmail(message: nil)

        #expect(!rule.validate("test@example.c"))
    }

    @Test
    func `Has correct code property`() async throws {
        let rule = StringIsEmail(message: nil)
        #expect(rule.code == "email_string")
    }

    @Test
    func `Has correct message property`() async throws {
        let ruleWithoutMessage = StringIsEmail(message: nil)
        #expect(ruleWithoutMessage.message == nil)

        let ruleWithMessage = StringIsEmail(message: "Invalid email")
        #expect(ruleWithMessage.message == "Invalid email")
    }
}
