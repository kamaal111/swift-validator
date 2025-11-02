//
//  ValueValidatable.swift
//  swift-validator
//
//  Created by Kamaal M Farah on 16/06/2024.
//

/// A protocol that represents a validator with validation results.
///
/// Types conforming to this protocol encapsulate the result of validating a value
/// against one or more validation rules. The result includes both the validity status
/// and an optional error message.
///
/// Example:
/// ```swift
/// struct StringValidator: ValueValidatable {
///     public var result: (valid: Bool, message: String?)
///
///     public init(value: String, validators: [any StringValidatableRule]) {
///         let invalidity = validators.first(where: { !$0.validate(value) })
///         self.result = (invalidity == nil, invalidity?.message)
///     }
/// }
/// ```
protocol ValueValidatable {}
