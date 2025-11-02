//
//  StringValidatableRule.swift
//  swift-validator
//
//  Created by Kamaal M Farah on 16/06/2024.
//

/// A specialized validation rule protocol for `String` values.
///
/// This protocol inherits from ``ValidatableRule`` and constrains the `Value` type to `String`,
/// making it specifically designed for string validation rules. Use this protocol when creating
/// validation rules that work exclusively with strings, such as email validation, minimum length checks, etc.
///
/// String-specific rules conforming to this protocol can be used with ``StringValidator``
/// to validate string values against multiple criteria.
///
/// Example:
/// ```swift
/// class StringIsEmail: ValidatableRule, StringValidatableRule {
///     public let code = "email_string"
///     public let message: String?
///
///     public init(message: String? = nil) {
///         self.message = message
///     }
///
///     public func validate(_ value: String) -> Bool {
///         // Email validation logic
///         return value.contains("@")
///     }
/// }
/// ```
public protocol StringValidatableRule: ValidatableRule where Value == String {}
