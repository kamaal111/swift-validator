//
//  ValidateIsNotEmpty.swift
//  swift-validator
//
//  Created by Kamaal M Farah on 02/11/2025.
//

import Foundation

public class ValidateIsNotEmpty<Value: Collection>: ValidatableRule {
    public let code = "is_not_empty"
    public let message: String?

    public init(message: String? = nil) {
        self.message = message
    }

    public func validate(_ value: Value) -> Bool {
        !value.isEmpty
    }
}

extension ValidateIsNotEmpty: Equatable {
    public static func == (lhs: ValidateIsNotEmpty<Value>, rhs: ValidateIsNotEmpty<Value>) -> Bool {
        lhs.message == rhs.message
    }
}
