//
//  StringIsEmail.swift
//  swift-validator
//
//  Created by Kamaal M Farah on 2/16/25.
//

import Foundation

/// A validation rule that checks if a string is a valid email address.
///
/// This rule validates email addresses using a regular expression pattern that checks for:
/// - Valid characters before and after the @ symbol
/// - Proper domain structure with at least one dot
/// - Top-level domain with at least 2 characters
/// - No leading/trailing dots or consecutive dots
///
/// Example:
/// ```swift
/// let rule = StringIsEmail(message: "Invalid email address")
/// rule.validate("user@example.com")    // true
/// rule.validate("test+tag@domain.org") // true
/// rule.validate("invalid@")            // false
/// rule.validate("@example.com")        // false
///
/// // Use with StringValidator
/// let validator = StringValidator(value: "user@test.com", validators: [rule])
/// print(validator.result.valid) // true
/// ```
public class StringIsEmail: ValidatableRule, StringValidatableRule {
    /// The unique identifier for this validation rule: `"email_string"`.
    public let code = "email_string"

    /// An optional custom error message to display when validation fails.
    public let message: String?

    /// Creates a new validation rule to check if a string is a valid email address.
    ///
    /// - Parameter message: An optional custom error message to display when validation fails.
    ///                      Defaults to `nil`.
    public init(message: String? = nil) {
        self.message = message
    }

    /// Validates that the given string is a valid email address.
    ///
    /// The validation checks for proper email format including:
    /// - Valid username characters (alphanumeric, dots, hyphens, underscores, plus signs)
    /// - @ symbol
    /// - Valid domain name
    /// - Top-level domain with at least 2 characters
    ///
    /// - Parameter value: The string to validate as an email address.
    /// - Returns: `true` if the string is a valid email format, `false` otherwise.
    public func validate(_ value: String) -> Bool {
        let emailRegEx =
            "(?i)^(?!\\.)(?!.*\\.\\.)([A-Z0-9_'+\\-\\.]*[A-Z0-9_+\\-])@([A-Z0-9][A-Z0-9\\-]*\\.)+[A-Z]{2,}$"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)

        return emailPred.evaluate(with: value)
    }
}
