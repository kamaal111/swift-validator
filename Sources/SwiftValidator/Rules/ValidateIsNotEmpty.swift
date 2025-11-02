//
//  ValidateIsNotEmpty.swift
//  swift-validator
//
//  Created by Kamaal M Farah on 02/11/2025.
//

import Foundation

/// A validation rule that checks if a collection is not empty.
///
/// This rule validates that a collection (such as `String`, `Array`, `Dictionary`, `Set`, etc.)
/// contains at least one element. It works with any type conforming to the `Collection` protocol.
///
/// Example:
/// ```swift
/// let rule = ValidateIsNotEmpty<String>(message: "String cannot be empty")
/// rule.validate("")        // false
/// rule.validate("hello")   // true
///
/// let arrayRule = ValidateIsNotEmpty<[Int]>()
/// arrayRule.validate([])         // false
/// arrayRule.validate([1, 2, 3])  // true
/// ```
public class ValidateIsNotEmpty<Value: Collection>: ValidatableRule {
    /// The unique identifier for this validation rule: `"is_not_empty"`.
    public let code = "is_not_empty"

    /// An optional custom error message to display when validation fails.
    public let message: String?

    /// Creates a new validation rule to check if a collection is not empty.
    ///
    /// - Parameter message: An optional custom error message to display when validation fails.
    ///                      Defaults to `nil`.
    public init(message: String? = nil) {
        self.message = message
    }

    /// Validates that the given collection is not empty.
    ///
    /// - Parameter value: The collection to validate.
    /// - Returns: `true` if the collection contains at least one element, `false` if empty.
    public func validate(_ value: Value) -> Bool {
        !value.isEmpty
    }
}

extension ValidateIsNotEmpty: Equatable {
    public static func == (lhs: ValidateIsNotEmpty<Value>, rhs: ValidateIsNotEmpty<Value>) -> Bool {
        lhs.message == rhs.message
    }
}
