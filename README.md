# SwiftValidator

A flexible and type-safe validation framework for Swift that provides a protocol-based approach to validating values against custom rules.

- [SwiftValidator](#swiftvalidator)
  - [Features](#features)
  - [Installation](#installation)
    - [Swift Package Manager](#swift-package-manager)
  - [Usage](#usage)
    - [Basic Validation](#basic-validation)
      - [Validating Collections](#validating-collections)
      - [Validating Value Equality](#validating-value-equality)
    - [String Validation](#string-validation)
      - [Email Validation](#email-validation)
      - [Word Count Validation](#word-count-validation)
      - [String Minimum Length](#string-minimum-length)
      - [String Value Equality](#string-value-equality)
      - [String Not Empty](#string-not-empty)
    - [Composing Multiple Validators](#composing-multiple-validators)
    - [Custom Error Messages](#custom-error-messages)
  - [API Reference](#api-reference)
    - [Protocols](#protocols)
      - [`ValidatableRule`](#validatablerule)
      - [`StringValidatableRule`](#stringvalidatablerule)
      - [`ValueValidatable`](#valuevalidatable)
    - [Generic Rules](#generic-rules)
      - [`ValidateIsNotEmpty<Value: Collection>`](#validateisnotemptyvalue-collection)
      - [`ValidateIsSameValue<Value: Equatable>`](#validateissamevaluevalue-equatable)
      - [`ValidateMinimumLength<Value: Collection>`](#validateminimumlengthvalue-collection)
    - [String Rules](#string-rules)
      - [`StringIsNotEmpty`](#stringisnotempty)
      - [`StringIsEmail`](#stringisemail)
      - [`StringIsTheSameValue`](#stringisthesamevalue)
      - [`StringValidateMinimumLength`](#stringvalidateminimumlength)
      - [`StringValidateWordCount`](#stringvalidatewordcount)
    - [Validators](#validators)
      - [`StringValidator`](#stringvalidator)
  - [Creating Custom Validation Rules](#creating-custom-validation-rules)
    - [Generic Rule](#generic-rule)
    - [String-Specific Rule](#string-specific-rule)
  - [Testing](#testing)

## Features

- ✅ Protocol-based validation system
- ✅ Generic validation rules for any type
- ✅ String-specific validation rules with composition support
- ✅ Type-safe with Swift's generics
- ✅ Customizable error messages
- ✅ Built with Swift Testing framework

## Installation

### Swift Package Manager

Add SwiftValidator to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/kamaal111/swift-validator.git", branch: "main")
]
```

> **Note:** This library is currently in beta. We recommend pinning to the `main` branch until a stable release is available.

## Usage

### Basic Validation

#### Validating Collections

Check if a collection is not empty:

```swift
import SwiftValidator

let rule = ValidateIsNotEmpty<String>()
let isValid = rule.validate("Hello") // true

let emptyRule = ValidateIsNotEmpty<[Int]>()
let isValidArray = emptyRule.validate([1, 2, 3]) // true
let isInvalidArray = emptyRule.validate([]) // false
```

Check minimum length requirements:

```swift
let rule = ValidateMinimumLength(length: 3)
let isValid = rule.validate("Hello") // true
let isInvalid = rule.validate("Hi") // false
```

#### Validating Value Equality

Check if a value equals an expected value:

```swift
let rule = ValidateIsSameValue(value: 42)
let isValid = rule.validate(42) // true
let isInvalid = rule.validate(100) // false
```

### String Validation

#### Email Validation

```swift
let emailRule = StringIsEmail()
let isValid = emailRule.validate("user@example.com") // true
let isInvalid = emailRule.validate("invalid-email") // false
```

#### Word Count Validation

Validates exact word count with strict spacing rules:

```swift
let rule = StringValidateWordCount(wordCount: 3)
let isValid = rule.validate("Hello world there") // true
let isInvalid = rule.validate("Hello  world") // false (double space)
```

#### String Minimum Length

```swift
let rule = StringValidateMinimumLength(length: 5)
let isValid = rule.validate("Hello") // true
let isInvalid = rule.validate("Hi") // false
```

#### String Value Equality

```swift
let rule = StringIsTheSameValue(value: "expected")
let isValid = rule.validate("expected") // true
let isInvalid = rule.validate("different") // false
```

#### String Not Empty

```swift
let rule = StringIsNotEmpty()
let isValid = rule.validate("Hello") // true
let isInvalid = rule.validate("") // false
```

#### Numeric String Validation

```swift
let rule = StringIsNumeric()
let isValid = rule.validate("123") // true
let isValidDecimal = rule.validate("123.45") // true
let isValidNegative = rule.validate("-42") // true
let isInvalid = rule.validate("abc") // false

// With custom locale for different decimal separators
let germanRule = StringIsNumeric(locale: Locale(identifier: "de_DE"))
let isValidGerman = germanRule.validate("123,45") // true (comma as decimal separator)
```

### Composing Multiple Validators

Use `StringValidator` to validate a string against multiple rules:

```swift
let validator = StringValidator(
    value: "user@example.com",
    validators: [
        StringIsNotEmpty(),
        StringIsEmail()
    ]
)

if validator.result.valid {
    print("Valid email")
} else {
    print("Error: \(validator.result.message ?? "Validation failed")")
}
```

### Custom Error Messages

All validation rules support custom error messages:

```swift
let rule = StringIsNotEmpty(message: "Username cannot be empty")
let isValid = rule.validate("")

if !isValid {
    print(rule.message) // "Username cannot be empty"
}
```

Example with multiple rules:

```swift
let validator = StringValidator(
    value: "",
    validators: [
        StringIsNotEmpty(message: "Email is required"),
        StringIsEmail(message: "Email format is invalid")
    ]
)

if !validator.result.valid {
    print(validator.result.message ?? "Unknown error")
    // Prints: "Email is required"
}
```

## API Reference

### Protocols

#### `ValidatableRule`

The base protocol for all validation rules.

```swift
protocol ValidatableRule {
    associatedtype Value
    var code: String { get }
    var message: String? { get }
    func validate(_ value: Value) -> Bool
}
```

#### `StringValidatableRule`

A protocol for string-specific validation rules that can be composed with `StringValidator`.

```swift
protocol StringValidatableRule: ValidatableRule where Value == String { }
```

#### `ValueValidatable`

A protocol that represents a validator with validation results.

```swift
protocol ValueValidatable { }
```

### Generic Rules

#### `ValidateIsNotEmpty<Value: Collection>`

Validates that a collection is not empty.

- **Parameters:**
  - `message`: Optional custom error message
- **Returns:** `true` if the collection contains at least one element

#### `ValidateIsSameValue<Value: Equatable>`

Validates that a value equals an expected value.

- **Parameters:**
  - `value`: The expected value to compare against
  - `message`: Optional custom error message
- **Returns:** `true` if the validated value equals the expected value

#### `ValidateMinimumLength<Value: Collection>`

Validates that a collection meets a minimum length requirement.

- **Parameters:**
  - `length`: The minimum number of elements required
  - `message`: Optional custom error message
- **Returns:** `true` if the collection has at least the specified number of elements

### String Rules

#### `StringIsNotEmpty`

Validates that a string is not empty.

- **Parameters:**
  - `message`: Optional custom error message
- **Returns:** `true` if the string contains at least one character

#### `StringIsEmail`

Validates that a string is a valid email address using regex pattern matching.

- **Valid email criteria:**
  - Local part: 1+ characters (letters, numbers, dots, hyphens, underscores, plus signs)
  - @ symbol
  - Domain: 1+ characters (letters, numbers, hyphens)
  - TLD: Dot followed by 2+ letters

- **Parameters:**
  - `message`: Optional custom error message
- **Returns:** `true` if the string matches the email pattern

#### `StringIsTheSameValue`

Validates that a string equals an expected string value.

- **Parameters:**
  - `value`: The expected string value to compare against
  - `message`: Optional custom error message
- **Returns:** `true` if the validated string equals the expected value

#### `StringValidateMinimumLength`

Validates that a string meets a minimum length requirement.

- **Parameters:**
  - `length`: The minimum number of characters required
  - `message`: Optional custom error message
- **Returns:** `true` if the string has at least the specified number of characters

#### `StringValidateWordCount`

Validates that a string contains an exact number of words with strict spacing rules.

- **Validation rules:**
  - No leading or trailing whitespace
  - Words separated by exactly one space
  - Exact word count match

- **Parameters:**
  - `wordCount`: The exact number of words required
  - `message`: Optional custom error message
- **Returns:** `true` if the string contains exactly the specified number of words

#### `StringIsNumeric`

Validates that a string contains only numeric characters and represents a valid numeric value.

- **Valid numeric formats:**
  - Positive and negative integers (e.g., "123", "-456")
  - Decimal numbers (e.g., "123.45", ".75")
  - Numbers in scientific notation (e.g., "1e10", "2.5e-3")
  - Leading/trailing whitespace is considered invalid

- **Parameters:**
  - `locale`: The locale to use for number parsing. Defaults to `en_US_POSIX` for consistent parsing.
              Can be customized to support different decimal separators (e.g., comma vs. period).
  - `message`: Optional custom error message
- **Returns:** `true` if the string represents a valid numeric value according to the locale

### Validators

#### `StringValidator`

A validator that validates a string against multiple validation rules.

```swift
public struct StringValidator: ValueValidatable {
    public var result: (valid: Bool, message: String?)
    public init(value: String, validators: [any StringValidatableRule])
}
```

- **Properties:**
  - `result`: Tuple containing validation status and optional error message
    - `valid`: `true` if all validators passed
    - `message`: Error message from the first failed validator, or `nil` if all passed

- **Parameters:**
  - `value`: The string value to validate
  - `validators`: Array of validation rules conforming to `StringValidatableRule`

## Creating Custom Validation Rules

### Generic Rule

Create a custom rule by conforming to `ValidatableRule`:

```swift
public final class ValidateIsPositive: ValidatableRule {
    public var code: String { "validate_is_positive" }
    public var message: String?

    public init(message: String? = nil) {
        self.message = message ?? "Value must be positive"
    }

    public func validate(_ value: Int) -> Bool {
        value > 0
    }
}
```

### String-Specific Rule

Create a string rule by conforming to `StringValidatableRule`:

```swift
public final class StringContainsUppercase: StringValidatableRule {
    public var code: String { "string_contains_uppercase" }
    public var message: String?

    public init(message: String? = nil) {
        self.message = message ?? "String must contain at least one uppercase letter"
    }

    public func validate(_ value: String) -> Bool {
        value.contains(where: { $0.isUppercase })
    }
}
```

## Testing

SwiftValidator is built with the Swift Testing framework. Run tests with:

```bash
swift test
```
