# Repository Guidelines

## Project Structure & Module Organization
- Sources: `Sources/SwiftValidator/` contains the library code.
  - Rules live in `Sources/SwiftValidator/Rules/` (e.g., `StringIsEmail.swift`).
  - Composers/validators live in `Sources/SwiftValidator/Validators/`.
- Tests: `Tests/SwiftValidatorTests/` contains unit tests (one file per rule, e.g., `StringIsEmailTests.swift`).
- Configuration: `.swift-format` enforces formatting rules.

## Build, Test, and Development Commands
- Build (debug): `swift build`
- Build (release): `swift build -c release`
- Run tests: `swift test`
- Code coverage: `swift test --enable-code-coverage`
- Format: `swift format --in-place --recursive Sources Tests` (uses `.swift-format` automatically)
- Open in Xcode: open the package directory in Xcode 15+ and use the SPM workspace.

## Coding Style & Naming Conventions
- Indentation: 4 spaces; line length: 120 (see `.swift-format`).
- Imports: ordered; allow trailing commas in multi-line collections.
- Naming: Types in UpperCamelCase; methods, variables, and cases in lowerCamelCase.
- Optionals: avoid force unwrap/try; prefer early exits when clearer.
- Documentation: use `///` for public APIs when helpful.

## Testing Guidelines
- Always add/update tests for every change. PRs without tests are not accepted.
- Framework: Swift Testing (`import Testing`, `@Test`, `#expect`).
- Structure: mirror files under `Tests/SwiftValidatorTests/` and name as `FeatureTests.swift`.
- Style: follow `Tests/SwiftValidatorTests/StringIsNotEmptyTests.swift` — use a `struct` per suite, annotate tests with `@Test`, prefer backticked descriptive function names, `#expect(...)` for assertions, and `@testable import SwiftValidator`.
- Example:
  ```swift
  import Testing
  @testable import SwiftValidator

  struct MyRuleTests {
      @Test
      func `Validates something`() async throws {
          let rule = MyRule()
          #expect(rule.validate("value"))
      }
  }
  ```
- Scope: cover success, failure, and edge cases (e.g., locales, boundaries).
- Run locally with `swift test` (this also compiles the package); keep the suite green.

## Agent-Specific Instructions
- Git operations are human-only: do not run `git` commands; the maintainer handles branching, commits, and PRs.
- Tests are mandatory for every change; keep the suite green with `swift test` (compiles + runs tests).
- Don't hand-format code: run `swift format --in-place --recursive Sources Tests` and rely on `.swift-format`. To lint (check formatting without modifying files), use `swift-format lint --recursive Sources Tests` if you have the `swift-format` tool installed.
- Keep changes focused and minimal; avoid unrelated refactors.
- **Always update the README.md** when adding new features, rules, or changing public APIs. This includes:
  - Adding usage examples in the "Usage" section for new rules/features
  - Updating the API Reference section with complete parameter and return value documentation
  - Adding entries to the table of contents for new sections
  - Ensuring code examples are accurate and follow the current API design

## Security & Configuration Tips
- Locale-sensitive logic: prefer deterministic defaults (e.g., `en_US_POSIX`) and test alternative locales explicitly.
- Regex and parsing: validate patterns with tests; avoid catastrophic backtracking.
