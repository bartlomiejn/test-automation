# test-automation

GitHub API authentication app based on a multi-project iOS app architecture with a three layer test automation strategy. Setup takes advantage of the architecture to deliver UI integration tests for isolated application modules along high-level end to end tests. 

### Overview

- Multi-project architecture with 5 separate modules and a shared collection of test-related tools: 
  - `App` - Runs the app, handles app-level events
  - `Core` - Core functionality library
  - `Main` - Main flow
  - `Authentication` - API authentication logic
  - `Networking` - Networking layer
  - `Shared` - UI test tools added statically to UI test targets
- Three layers of test automation:
  - Unit tests - `AuthenticationUnitTests`
    - Tests each unit of code
    - Isolates each unit mocking all of its dependencies
    - Covers `AuthenticationPresenter` in `AuthenticationPresenterTests`
  - Integration tests - `AuthenticationIntegrationTests`
    - Tests integration of `AuthenticationModule` on a dummy app target
    - Isolates the module mocking all of its dependencies - API and `MainModule`
    - Covers authentication success and failure paths in `AuthenticationTests` test case
  - End to end tests - `AppEndToEndTests`
    - Tests the integration of the whole application stack
    - Covers both `MainModule` and `AuthenticationModule` on a real app target
    - Involves both application and the GitHub API
    - Covers authentication success and failure paths in `AppTests` test case
- HTTP request stubbing capabilities using `HTTPNetworkClient` with `StubbedURLSession`
- Feature modules can be implemented using any sort of architectural pattern - `Authentication` is implemented using `VIPER`
