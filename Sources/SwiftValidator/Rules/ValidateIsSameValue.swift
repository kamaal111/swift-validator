//
//  ValidateIsSameValue.swift
//  swift-validator
//
//  Created by Kamaal M Farah on 06/07/2024.
//

/// A validation rule that checks if a value equals a specific expected value.
///
/// This rule validates that the provided value matches exactly with a predefined comparison value.
/// It works with any type conforming to the `Equatable` protocol.
///
/// Example:
/// ```swift
/// let rule = ValidateIsSameValue(value: 42, message: "Value must be 42")
/// rule.validate(42)  // true
/// rule.validate(41)  // false
///
/// let stringRule = ValidateIsSameValue(value: "password123")
/// stringRule.validate("password123")  // true
/// stringRule.validate("wrong")        // false
/// ```
public class ValidateIsSameValue<Value: Equatable>: ValidatableRule {
    /// The unique identifier for this validation rule: `"same_value"`.
    public let code = "same_value"

    /// The expected value that the validated value should match.
    public let value: Value

    /// An optional custom error message to display when validation fails.
    public let message: String?

    /// Creates a new validation rule to check if a value equals the expected value.
    ///
    /// - Parameters:
    ///   - value: The expected value to compare against.
    ///   - message: An optional custom error message to display when validation fails.
    ///              Defaults to `nil`.
    public init(value: Value, message: String? = nil) {
        self.value = value
        self.message = message
    }

    /// Validates that the given value equals the expected value.
    ///
    /// - Parameter value: The value to validate.
    /// - Returns: `true` if the value equals the expected value, `false` otherwise.
    public func validate(_ value: Value) -> Bool {
        self.value == value
    }
}

extension ValidateIsSameValue: Equatable {
    public static func == (lhs: ValidateIsSameValue<Value>, rhs: ValidateIsSameValue<Value>) -> Bool {
        lhs.value == rhs.value && lhs.message == rhs.message
    }
}
