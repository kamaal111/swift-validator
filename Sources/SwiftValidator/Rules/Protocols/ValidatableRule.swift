//
//  ValidatableRule.swift
//  swift-validator
//
//  Created by Kamaal M Farah on 16/06/2024.
//

/// A protocol that defines a validation rule for a specific value type.
///
/// Conforming types implement validation logic to check if a value meets specific criteria.
/// Each rule has a unique code identifier and can provide a custom error message.
///
/// Example:
/// ```swift
/// class ValidateMinimumLength<Value: Collection>: ValidatableRule {
///     public let code = "minimum_length"
///     public let length: Int
///     public let message: String?
///
///     public init(length: Int, message: String? = nil) {
///         self.length = length
///         self.message = message
///     }
///
///     public func validate(_ value: Value) -> Bool {
///         value.count >= length
///     }
/// }
/// ```
public protocol ValidatableRule {
    /// The type of value this rule validates.
    associatedtype Value

    /// A unique identifier for this validation rule.
    ///
    /// This code is used to distinguish between different validation rules
    /// and should be unique within a validator's rule set.
    var code: String { get }

    /// An optional custom error message to display when validation fails.
    ///
    /// If `nil`, the validator may use a default error message.
    var message: String? { get }

    /// Validates the given value according to the rule's criteria.
    ///
    /// - Parameter value: The value to validate.
    /// - Returns: `true` if the value is valid according to this rule, `false` otherwise.
    func validate(_ value: Value) -> Bool
}
