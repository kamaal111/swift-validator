//
//  StringIsNumeric.swift
//  swift-validator
//
//  Created by Kamaal M Farah on 02/11/2025.
//

import Foundation

/// A validation rule that checks if a string contains only numeric characters.
///
/// This rule validates that a string represents a valid numeric value, which includes:
/// - Integer numbers (e.g., "123", "-456", "0")
/// - Decimal numbers (e.g., "123.45", "-0.5", ".75")
/// - Numbers in scientific notation (e.g., "1e10", "2.5e-3")
///
/// The validation uses Swift's built-in number parsing to determine if the string
/// can be represented as a numeric value.
///
/// Example:
/// ```swift
/// let rule = StringIsNumeric(message: "Value must be numeric")
/// rule.validate("123")        // true
/// rule.validate("123.45")     // true
/// rule.validate("-42")        // true
/// rule.validate("1e10")       // true
/// rule.validate("abc")        // false
/// rule.validate("12a34")      // false
/// rule.validate("")           // false
///
/// // Use with custom locale
/// let germanRule = StringIsNumeric(locale: Locale(identifier: "de_DE"))
/// germanRule.validate("123,45") // true (comma as decimal separator)
///
/// // Use with StringValidator
/// let validator = StringValidator(value: "42.5", validators: [rule])
/// print(validator.result.valid) // true
/// ```
public class StringIsNumeric: ValidatableRule, StringValidatableRule {
    /// The unique identifier for this validation rule: `"numeric_string"`.
    public let code = "numeric_string"

    /// An optional custom error message to display when validation fails.
    public let message: String?

    /// The locale used for number parsing.
    public let locale: Locale

    /// Creates a new validation rule to check if a string is numeric.
    ///
    /// - Parameters:
    ///   - locale: The locale to use for number parsing. Defaults to `en_US_POSIX` for consistent
    ///             parsing across different system locales.
    ///   - message: An optional custom error message to display when validation fails.
    ///              Defaults to `nil`.
    public init(locale: Locale = Locale(identifier: "en_US_POSIX"), message: String? = nil) {
        self.message = message
        self.locale = locale
    }

    /// Validates that the given string contains only numeric characters.
    ///
    /// The validation accepts:
    /// - Positive and negative integers
    /// - Decimal numbers
    /// - Numbers in scientific notation
    /// - Leading/trailing whitespace is considered invalid
    ///
    /// The validation behavior may vary based on the configured locale. For example,
    /// some locales use commas as decimal separators instead of periods.
    ///
    /// - Parameter value: The string to validate as numeric.
    /// - Returns: `true` if the string represents a valid numeric value, `false` otherwise.
    public func validate(_ value: String) -> Bool {
        let trimmedValue = value.trimmingCharacters(in: .whitespacesAndNewlines)
        guard trimmedValue == value else { return false }
        guard !value.isEmpty else { return false }

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = locale

        return formatter.number(from: value) != nil
    }
}
