//
//  StringValidateMinimumLength.swift
//  swift-validator
//
//  Created by Kamaal M Farah on 16/06/2024.
//

/// A validation rule that checks if a string meets a minimum length requirement.
///
/// This is a specialized version of ``ValidateMinimumLength`` for `String` values,
/// conforming to ``StringValidatableRule`` to be used with ``StringValidator``.
///
/// Example:
/// ```swift
/// let rule = StringValidateMinimumLength(length: 8, message: "Password too short")
/// rule.validate("hello")      // false (length 5)
/// rule.validate("password")   // true (length 8)
///
/// // Use with StringValidator
/// let validator = StringValidator(value: "test", validators: [rule])
/// print(validator.result.valid)   // false
/// print(validator.result.message) // "Password too short"
/// ```
public class StringValidateMinimumLength: ValidateMinimumLength<String>, StringValidatableRule {}
