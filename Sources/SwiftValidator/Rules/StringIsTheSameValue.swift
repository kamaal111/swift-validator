//
//  StringIsTheSameValue.swift
//  swift-validator
//
//  Created by Kamaal M Farah on 06/07/2024.
//

/// A validation rule that checks if a string equals a specific expected string value.
///
/// This is a specialized version of ``ValidateIsSameValue`` for `String` values,
/// conforming to ``StringValidatableRule`` to be used with ``StringValidator``.
///
/// Example:
/// ```swift
/// let rule = StringIsTheSameValue(value: "password123", message: "Incorrect password")
/// rule.validate("password123")  // true
/// rule.validate("wrong")        // false
///
/// // Use with StringValidator
/// let validator = StringValidator(value: "test", validators: [rule])
/// print(validator.result.valid) // false
/// ```
public class StringIsTheSameValue: ValidateIsSameValue<String>, StringValidatableRule {}
