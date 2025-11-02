//
//  ValidateMinimumLength.swift
//  swift-validator
//
//  Created by Kamaal M Farah on 16/06/2024.
//

import Foundation

/// A validation rule that checks if a collection meets a minimum length requirement.
///
/// This rule validates that a collection (such as `String`, `Array`, `Dictionary`, `Set`, etc.)
/// contains at least a specified number of elements. It works with any type conforming
/// to the `Collection` protocol.
///
/// Example:
/// ```swift
/// let rule = ValidateMinimumLength<String>(length: 5, message: "Too short")
/// rule.validate("hello")   // true
/// rule.validate("hi")      // false
///
/// let arrayRule = ValidateMinimumLength<[Int]>(length: 3)
/// arrayRule.validate([1, 2, 3])     // true
/// arrayRule.validate([1, 2])        // false
/// ```
public class ValidateMinimumLength<Value: Collection>: ValidatableRule {
    /// The unique identifier for this validation rule: `"minimum_length"`.
    public let code = "minimum_length"

    /// The minimum number of elements required in the collection.
    public let length: Int

    /// An optional custom error message to display when validation fails.
    public let message: String?

    /// Creates a new validation rule to check if a collection meets a minimum length.
    ///
    /// - Parameters:
    ///   - length: The minimum number of elements required.
    ///   - message: An optional custom error message to display when validation fails.
    ///              Defaults to `nil`.
    public init(length: Int, message: String? = nil) {
        self.length = length
        self.message = message
    }

    /// Validates that the given collection contains at least the minimum number of elements.
    ///
    /// - Parameter value: The collection to validate.
    /// - Returns: `true` if the collection has at least `length` elements, `false` otherwise.
    public func validate(_ value: Value) -> Bool {
        value.count >= length
    }
}

extension ValidateMinimumLength: Equatable {
    public static func == (lhs: ValidateMinimumLength<Value>, rhs: ValidateMinimumLength<Value>) -> Bool {
        lhs.length == rhs.length && lhs.message == rhs.message
    }
}
