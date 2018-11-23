# test-automation

Multi-project iOS architecture with VIPER-based modules with test automation examples based on a GitHub authentication app. Setup takes advantage of multi-project architecture to deliver UI integration tests for isolated application modules alongside End To End UI tests. Used as an example for the `Test Automation in iOS` lecture for the `meet.mobile` meetup in Wroclaw, Poland 10.10.2018.

### `AuthenticationUnitTests` (XCTest)
- Tests each unit of code
- Isolates each unit mocking all of its dependencies
- Example class - `AuthenticationPresenter` in `AuthenticationPresenterTests`

### `AuthenticationIntegrationTests` (XCUITest)
- Tests integration of `AuthenticationModule` on a dummy app target
- Uses built-in mocking infrastructure - `HTTPNetworkClient` / `StubbedURLSession`
- Isolates the module mocking all of its dependencies - API and `MainModule`
- Covers authentication success and failure paths in `AuthenticationTests` test case

### `AppEndToEndTests` (XCUITest)
- Tests the integration of the whole application stack
- Covers both `MainModule` and `AuthenticationModule` on a real app target
- Involves both application and the GitHub API
- Covers authentication success and failure paths in `AppTests` test case
