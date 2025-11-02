//
//  StringValidator.swift
//  swift-validator
//
//  Created by Kamaal M Farah on 16/06/2024.
//

/// A validator that validates a string against multiple string validation rules.
///
/// `StringValidator` combines multiple string validation rules and evaluates them
/// in sequence. It stops at the first validation failure and returns the result
/// with the corresponding error message.
///
/// Example with single rule:
/// ```swift
/// let validator = StringValidator(
///     value: "user@example.com",
///     validators: [StringIsEmail()]
/// )
/// if validator.result.valid {
///     print("Valid email")
/// } else {
///     print("Error: \(validator.result.message ?? "Unknown error")")
/// }
/// ```
///
/// Example with multiple rules:
/// ```swift
/// let validator = StringValidator(
///     value: "password123",
///     validators: [
///         StringIsNotEmpty(),
///         StringValidateMinimumLength(length: 8)
///     ]
/// )
/// ```
public struct StringValidator: ValueValidatable {
    /// The result of the validation containing validity status and optional error message.
    ///
    /// - `valid`: `true` if the value passed all validators, `false` otherwise
    /// - `message`: Error message from the first failed validator, or `nil` if all validators passed
    public var result: (valid: Bool, message: String?)

    /// Creates a string validator that validates a value against multiple validation rules.
    ///
    /// The validators are executed in order, and validation stops at the first failure.
    /// Each validator's code must be unique (enforced by an assertion).
    ///
    /// - Parameters:
    ///   - value: The string value to validate
    ///   - validators: An array of validation rules conforming to `StringValidatableRule`
    ///
    /// - Note: This initializer will assert if multiple validators have the same code
    public init(value: String, validators: [any StringValidatableRule]) {
        assert(
            Dictionary(grouping: validators, by: \.code).values.flatMap({ $0 }).count == validators.count,
            "Codes should be unique")
        let invalidity = validators.first(where: { validator in !validator.validate(value) })
        self.result = (invalidity == nil, invalidity?.message)
    }
}

extension StringValidator: Equatable {
    public static func == (lhs: StringValidator, rhs: StringValidator) -> Bool {
        lhs.result == rhs.result
    }
}
