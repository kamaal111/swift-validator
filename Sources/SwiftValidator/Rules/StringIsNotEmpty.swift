//
//  StringIsNotEmpty.swift
//  swift-validator
//
//  Created by Kamaal M Farah on 02/11/2025.
//

/// A validation rule that checks if a string is not empty.
///
/// This is a specialized version of ``ValidateIsNotEmpty`` for `String` values,
/// conforming to ``StringValidatableRule`` to be used with ``StringValidator``.
///
/// Example:
/// ```swift
/// let rule = StringIsNotEmpty(message: "String cannot be empty")
/// rule.validate("")        // false
/// rule.validate("hello")   // true
/// rule.validate("  ")      // true (spaces count as content)
///
/// // Use with StringValidator
/// let validator = StringValidator(value: "test", validators: [rule])
/// print(validator.result.valid) // true
/// ```
public class StringIsNotEmpty: ValidateIsNotEmpty<String>, StringValidatableRule {}
