# test-automation-ios

An iOS App which attempts to authenticate with the GitHub API and displays success or failure depending on the result. Used as an example for the `Test Automation in iOS` lecture for the `meet.mobile` meetup in Wroclaw, Poland 10.10.2018. Extended to feature component UI tests running on a dummy app.

### Unit test (XCTest)
- Treating a single class as a unit
- Isolating each unit mocking all of its dependencies
- Single class example (`AuthenticationPresenterTests`)

### Component tests (XCUITest)
- Tests integration of a single module
- Isolates the application mocking all of its dependencies (API)
- Uses built-in mocking infrastructure (`HTTPNetworkClient` \ `StubbedURLSession`)
- Single module example (`AuthenticationTests`) - success and failure cases

### Integration tests (XCUITest)
- Tests the integration of the whole application
- Other parameters as above

### End to end / System tests (XCUITest)
- Tests the integration of the whole application stack
- Involves both application and the GitHub API
- Single module example - same as above

### Potential optimizations
- Built-in infrastructure doesn't allow for mocking behaviour - a mock server would probably be more appropriate for such cases
