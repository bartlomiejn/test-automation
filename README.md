# test-automation-ios

An iOS App authenticating with the GitHub API and displays success or failure depending on the result. Used as an example for the `Test Automation in iOS` lecture for the `meet.mobile` meetup in Wroclaw, Poland 10.10.2018.

### Unit test (XCTest)
- Treating a single class as a unit
- Isolating each unit mocking all of its dependencies
- Single class example (`AuthenticationPresenterTests`)

### Integration tests (XCUITest)
- Tests integration of the whole application
- Isolates the application mocking all of its dependencies (API)
- Uses built-in mocking infrastructure (`HTTPNetworkClient` \ `StubbedURLSession`)
- Single module example (`AuthenticationTests`) - success and failure cases

### End to end tests (XCUITest)
- Tests the integration of the whole application stack
- Involves both application and the GitHub API
- Single module example - same as above

### Potential optimizations
- UI test suites duplicate the same code. Can be solved by:
  - Extracting a shared framework for UI test suites
  - Moving the shared files to a separate place and referencing them in each test target
- Built-in infrastructure doesn't allow for mocking of complex behaviour - a mock server would probably be more appropriate for such cases
- Replace environment vars check in `AppDelegate` with preprocessor directives cutting out all stubbing behaviour from the production version
