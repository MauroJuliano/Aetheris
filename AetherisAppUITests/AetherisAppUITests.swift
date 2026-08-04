import XCTest

final class AetherisAppUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    @MainActor
    func testAuthentication_validCredentialsOpenHome() {
        launch()
        XCTAssertTrue(app.staticTexts["Welcome back!"].waitForExistence(timeout: 3))
        app.textFields["login.email"].tap()
        app.textFields["login.email"].typeText("melissa@aetheris.app")
        app.secureTextFields["login.password"].tap()
        app.secureTextFields["login.password"].typeText("1234")
        app.buttons["Login"].tap()

        XCTAssertTrue(element("home.screen").waitForExistence(timeout: 5))
        XCTAssertTrue(element("tab.bar").exists)
    }

    @MainActor
    func testAuthentication_invalidCredentialsShowErrorAndAllowRetry() {
        launch()
        XCTAssertTrue(app.staticTexts["Welcome back!"].waitForExistence(timeout: 3))
        app.textFields["login.email"].tap()
        app.textFields["login.email"].typeText("wrong@aetheris.app")
        app.secureTextFields["login.password"].tap()
        app.secureTextFields["login.password"].typeText("9999")
        app.buttons["Login"].tap()

        XCTAssertTrue(app.staticTexts["Unable to sign in"].waitForExistence(timeout: 3))
        app.buttons["Try again"].tap()
        XCTAssertTrue(app.staticTexts["Welcome back!"].waitForExistence(timeout: 2))
    }

    @MainActor
    func testRegistration_completeFlowOpensHome() {
        launch()
        XCTAssertTrue(app.staticTexts["Welcome back!"].waitForExistence(timeout: 3))
        app.buttons["Sign up here"].tap()
        completeRegistrationStep(title: "Social Insurance Number", placeholder: "000.000.000", value: "123456789")
        completeRegistrationStep(title: "Mother's name", placeholder: "Jane doe", value: "Ana Maria")
        completeRegistrationStep(title: "Full name", placeholder: "John doe", value: "Melissa Test")
        completeRegistrationStep(title: "Date of birth", placeholder: "26/08/1970", value: "17081990")

        XCTAssertTrue(element("registration.resumeScreen").waitForExistence(timeout: 3))
        app.buttons["Continue"].tap()
        completeRegistrationStep(title: "Password", placeholder: "1234", value: "1234", secure: true)
        completeRegistrationStep(title: "Confirm password", placeholder: "1234", value: "1234", secure: true)

        XCTAssertTrue(element("home.screen").waitForExistence(timeout: 5))
    }

    @MainActor
    func testHomeFailure_retryRecoversDashboard() {
        launch(authenticated: true, additionalArguments: ["-uiTestingHomeFailureOnce"])
        XCTAssertTrue(app.staticTexts["Home unavailable"].waitForExistence(timeout: 3))
        app.buttons["Try again"].tap()

        XCTAssertTrue(element("home.screen").waitForExistence(timeout: 5))
        XCTAssertFalse(element("error.screen").exists)
    }

    @MainActor
    func testTabNavigationShowsHomeCardsAndProfile() {
        launch(authenticated: true)
        XCTAssertTrue(element("home.screen").waitForExistence(timeout: 5))

        app.buttons["Cards"].tap()
        XCTAssertTrue(element("cards.screen").waitForExistence(timeout: 5))
        app.buttons["Profile"].tap()
        XCTAssertTrue(element("profile.screen").waitForExistence(timeout: 5))
        app.buttons["Home"].tap()
        XCTAssertTrue(element("home.screen").waitForExistence(timeout: 5))
    }

    @MainActor
    func testTransfer_reachesSingleSuccessScreen() {
        launch(authenticated: true)
        enterValidTransfer()
        XCTAssertTrue(element("transfer.successScreen").waitForExistence(timeout: 5))
        XCTAssertEqual(app.descendants(matching: .any).matching(identifier: "transfer.successScreen").count, 1)
    }

    @MainActor
    func testTransfer_failureAllowsRetryWithSameOperation() {
        launch(authenticated: true, additionalArguments: ["-uiTestingTransferFailureOnce"])
        enterValidTransfer()

        XCTAssertTrue(element("transfer.processingError").waitForExistence(timeout: 5))
        app.buttons["Try again"].tap()

        XCTAssertTrue(element("transfer.successScreen").waitForExistence(timeout: 5))
    }

    @MainActor
    func testTransfer_invalidPinReturnsToSendMoney() {
        launch(authenticated: true)
        XCTAssertTrue(element("home.screen").waitForExistence(timeout: 5))
        app.buttons["Transfer"].tap()
        XCTAssertTrue(element("transfer.amountScreen").waitForExistence(timeout: 3))
        app.buttons["1"].tap()
        app.buttons["Continue"].tap()
        XCTAssertTrue(element("identity.validation.screen").waitForExistence(timeout: 3))

        ["0", "0", "0", "0"].forEach { _ in app.buttons["0"].tap() }

        XCTAssertTrue(element("identity.validation.errorSheet").waitForExistence(timeout: 3))
        app.buttons["Close"].tap()
        XCTAssertTrue(element("transfer.amountScreen").waitForExistence(timeout: 3))
    }

    @MainActor
    private func enterValidTransfer() {
        XCTAssertTrue(element("home.screen").waitForExistence(timeout: 5))
        app.buttons["Transfer"].tap()
        XCTAssertTrue(element("transfer.amountScreen").waitForExistence(timeout: 3))
        app.buttons["1"].tap()
        app.buttons["Continue"].tap()

        XCTAssertTrue(element("identity.validation.screen").waitForExistence(timeout: 3))
        ["1", "2, ABC", "3, DEF", "4, GHI"].forEach { app.buttons[$0].tap() }
    }

    private func launch(authenticated: Bool = false, additionalArguments: [String] = []) {
        app.launchArguments = ["-uiTesting"]
        if authenticated { app.launchArguments.append("-uiTestingAuthenticated") }
        app.launchArguments.append(contentsOf: additionalArguments)
        app.launch()
    }

    private func completeRegistrationStep(
        title: String,
        placeholder: String,
        value: String,
        secure: Bool = false
    ) {
        let titleElement = app.staticTexts[title]
        if !titleElement.waitForExistence(timeout: 3) {
            let continueButton = app.buttons["Continue"]
            if continueButton.exists && continueButton.isHittable {
                continueButton.tap()
            }
        }
        XCTAssertTrue(titleElement.waitForExistence(timeout: 3))
        let input = secure
            ? app.secureTextFields["registration.input"]
            : app.textFields["registration.input"]
        input.tap()
        input.typeText(value)
        app.buttons["Continue"].tap()
    }

    private func field(_ identifier: String) -> XCUIElement {
        app.descendants(matching: .any).matching(identifier: identifier).firstMatch
    }

    private func element(_ identifier: String) -> XCUIElement {
        app.descendants(matching: .any).matching(identifier: identifier).firstMatch
    }
}
