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
/// // Use with comparison options
/// let comparison = StringIsNumeric.Comparison(op: .greaterThan, value: 10)
/// let options = StringIsNumeric.Options(comparison: comparison)
/// let comparisonRule = StringIsNumeric(options: options)
/// comparisonRule.validate("15")  // true (15 > 10)
/// comparisonRule.validate("5")   // false (5 is not > 10)
///
/// // Use with StringValidator
/// let validator = StringValidator(value: "42.5", validators: [rule])
/// print(validator.result.valid) // true
/// ```
public class StringIsNumeric: ValidatableRule, StringValidatableRule {
    /// Comparison operators for numeric validation.
    public enum ComparisonOperator {
        /// Value must be greater than the comparison value.
        case greaterThan
        /// Value must be greater than or equal to the comparison value.
        case greaterThanOrEqualTo
        /// Value must be less than the comparison value.
        case lessThan
        /// Value must be less than or equal to the comparison value.
        case lessThanOrEqualTo
    }

    /// A comparison configuration for numeric validation.
    public struct Comparison {
        /// The comparison operator to use when validating numeric values.
        public let op: ComparisonOperator
        /// The value to compare against.
        public let value: Double

        /// Creates a new comparison instance.
        ///
        /// - Parameters:
        ///   - op: The comparison operator to use.
        ///   - value: The value to compare against.
        public init(op: ComparisonOperator, value: Double) {
            self.op = op
            self.value = value
        }
    }

    /// Options for configuring numeric validation behavior.
    public struct Options {
        /// The comparison configuration to use when validating numeric values.
        public let comparison: Comparison?

        /// Creates a new options instance.
        ///
        /// - Parameter comparison: Optional comparison configuration. Defaults to `nil` (no comparison).
        public init(comparison: Comparison? = nil) {
            self.comparison = comparison
        }
    }

    /// The unique identifier for this validation rule: `"numeric_string"`.
    public let code = "numeric_string"

    /// An optional custom error message to display when validation fails.
    public let message: String?

    /// The locale used for number parsing.
    public let locale: Locale

    /// The options for configuring validation behavior.
    public let options: Options

    /// Creates a new validation rule to check if a string is numeric.
    ///
    /// - Parameters:
    ///   - locale: The locale to use for number parsing. Defaults to `en_US_POSIX` for consistent
    ///             parsing across different system locales.
    ///   - options: Optional validation options for numeric comparison. Defaults to no comparison.
    ///   - message: An optional custom error message to display when validation fails.
    ///              Defaults to `nil`.
    public init(
        locale: Locale = Locale(identifier: "en_US_POSIX"),
        options: Options = Options(),
        message: String? = nil
    ) {
        self.message = message
        self.locale = locale
        self.options = options
    }

    @available(*, deprecated, renamed: "init(locale:options:message:)")
    public convenience init(message: String?, locale: Locale) {
        self.init(locale: locale, message: message)
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
    /// If comparison options are provided, the numeric value will also be compared
    /// against the specified comparison value using the specified operator.
    ///
    /// - Parameter value: The string to validate as numeric.
    /// - Returns: `true` if the string represents a valid numeric value and passes
    ///            any comparison checks, `false` otherwise.
    public func validate(_ value: String) -> Bool {
        let trimmedValue = value.trimmingCharacters(in: .whitespacesAndNewlines)
        guard trimmedValue == value else { return false }
        guard !value.isEmpty else { return false }

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = locale

        guard let number = formatter.number(from: value) else { return false }
        guard let comparison = options.comparison else { return true }

        let doubleValue = number.doubleValue
        switch comparison.op {
        case .greaterThan:
            return doubleValue > comparison.value
        case .greaterThanOrEqualTo:
            return doubleValue >= comparison.value
        case .lessThan:
            return doubleValue < comparison.value
        case .lessThanOrEqualTo:
            return doubleValue <= comparison.value
        }
    }
}
