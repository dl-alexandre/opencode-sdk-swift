## Setting up the environment

### With Swift Package Manager

This repository uses Swift Package Manager (SPM) for dependency management. To set it up, ensure you have Swift 6.2 or later installed, then:

```sh
$ swift build
```

To run tests:

```sh
$ swift test
```

To run a specific test:

```sh
$ swift test --filter <test-name>
```

## Modifying/Adding code

Most of the SDK is generated code. Modifications to code will be persisted between generations, but may
result in merge conflicts between manual patches and changes from the generator. The generator will never
modify the contents of the `Sources/opencode-sdk-swift/Core/` directory.

## Adding and running examples

All files in the `examples/` directory are not modified by the generator and can be freely edited or added to.

## Using the repository from source

If you'd like to use the repository from source, you can add it as a Swift Package dependency:

```swift
dependencies: [
    .package(url: "https://github.com/anomalyco/opencode-sdk-swift.git", from: "1.0.0")
]
```

Alternatively, you can link to a local cloned repository:

```swift
dependencies: [
    .package(path: "../opencode-sdk-swift")
]
```

## Running tests

Most tests require you to [set up a mock server](https://github.com/stoplightio/prism) against the OpenAPI spec to run the tests.

```sh
# you will need npm installed
$ npx prism mock path/to/your/openapi.yml
```

```sh
$ swift test
```

## Linting and formatting

This repository follows Swift standard formatting conventions. While there's no specific linting configuration checked in, please follow the existing code style:

- 4-space indentation
- Opening braces on the same line
- Explicit access control (`public`, `private`)
- Follow existing naming conventions (UpperCamelCase for types, lowerCamelCase for properties)

## Publishing and releases

Changes made to this repository via the automated release PR pipeline should publish automatically. If
the changes aren't made through the automated pipeline, you may want to make releases manually.

### Publish with a GitHub workflow

You can release by using the GitHub Actions workflow. This requires appropriate secrets to be set up.

### Publish manually

If you need to manually release a package, ensure all tests pass and create a git tag for the release version.
