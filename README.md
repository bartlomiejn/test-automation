# test-automation

iOS App which authenticates with the GitHub API and displays success or failure depending on the result.

Used as an example for the `Test Automation in iOS` lecture for the `meet.mobile` meetup in Wroclaw, Poland 10.10.2018. Later extended to support a multi-project app architecture with integration tests per module.

### `AuthenticationUnitTests` (XCTest)
- Tests each unit of code
- Isolates each unit mocking all of its dependencies
- Example class - `AuthenticationPresenter` in `AuthenticationPresenterTests`

### `AuthenticationIntegrationTests` (XCUITest)
- Tests integration of `AuthenticationModule` on a dummy app target
- Uses built-in mocking infrastructure - `HTTPNetworkClient` / `StubbedURLSession`
- Isolates the module mocking all of its dependencies - API and `MainModule`
- Example case - Authentication success and failure paths in `AuthenticationTests`

### `AppEndToEndTests` (XCUITest)
- Tests the integration of the whole application stack
- Covers both `MainModule` and `AuthenticationModule` on a real app target
- Involves both application and the GitHub API
- Example case - Authentication success and failure paths in `AppTests`
