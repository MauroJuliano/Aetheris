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
        XCTAssertTrue(element("login.screen").waitForExistence(timeout: 3))
        enterText("blake.lehmann@aetheris.app", in: app.textFields["login.email"])
        enterText("4321", in: app.secureTextFields["login.password"])
        element("login.submit").tap()

        XCTAssertTrue(element("home.screen").waitForExistence(timeout: 5))
        XCTAssertTrue(element("tab.bar").exists)
    }

    @MainActor
    func testAuthentication_invalidCredentialsShowErrorAndAllowRetry() {
        launch()
        XCTAssertTrue(element("login.screen").waitForExistence(timeout: 3))
        enterText("wrong@aetheris.app", in: app.textFields["login.email"])
        enterText("9999", in: app.secureTextFields["login.password"])
        element("login.submit").tap()

        XCTAssertTrue(element("actionError.title").waitForExistence(timeout: 3))
        element("actionError.primary").tap()
        XCTAssertTrue(element("login.screen").waitForExistence(timeout: 2))
    }

    @MainActor
    func testRegistration_completeFlowOpensHome() {
        launch()
        XCTAssertTrue(element("login.screen").waitForExistence(timeout: 3))
        element("login.register").tap()
        if !element("registration.step.sin").waitForExistence(timeout: 3) {
            element("login.register").tap()
        }
        completeRegistrationStep(identifier: "sin", value: "123456789")
        completeRegistrationStep(identifier: "motherName", value: "Ana Maria")
        completeRegistrationStep(identifier: "fullName", value: "Melissa Test")
        completeRegistrationStep(identifier: "email", value: "melissa.test@example.com")
        completeRegistrationStep(identifier: "birthdate", value: "17081990")

        XCTAssertTrue(element("registration.resumeContinue").waitForExistence(timeout: 8))
        element("registration.resumeContinue").tap()
        completeRegistrationStep(identifier: "password", value: "1234", secure: true)
        completeRegistrationStep(identifier: "confirmPassword", value: "1234", secure: true)

        XCTAssertTrue(element("registration.onboardingFinish").waitForExistence(timeout: 8))
        element("registration.onboardingFinish").tap()

        XCTAssertTrue(element("home.screen").waitForExistence(timeout: 5))
    }

    @MainActor
    func testHomeFailure_retryRecoversDashboard() {
        launch(authenticated: true, additionalArguments: ["-uiTestingHomeFailureOnce"])
        XCTAssertTrue(element("error.retry").waitForExistence(timeout: 3))
        element("error.retry").tap()

        XCTAssertTrue(element("home.screen").waitForExistence(timeout: 5))
        XCTAssertFalse(element("error.screen").exists)
    }

    @MainActor
    func testTabNavigationShowsHomeCardsAndProfile() {
        launch(authenticated: true)
        XCTAssertTrue(element("home.screen").waitForExistence(timeout: 5))

        element("tab.1").tap()
        XCTAssertTrue(element("cards.screen").waitForExistence(timeout: 5))
        element("tab.2").tap()
        XCTAssertTrue(element("profile.screen").waitForExistence(timeout: 5))
        element("tab.0").tap()
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
        element("error.retry").tap()

        XCTAssertTrue(element("transfer.successScreen").waitForExistence(timeout: 5))
    }

    @MainActor
    func testTransfer_invalidPinReturnsToSendMoney() {
        launch(authenticated: true)
        XCTAssertTrue(element("home.screen").waitForExistence(timeout: 5))
        element("tab.transfer").tap()
        XCTAssertTrue(element("transfer.amountScreen").waitForExistence(timeout: 3))
        element("amount.key.1").tap()
        selectTransferBeneficiary()
        element("transfer.continue").tap()
        XCTAssertTrue(element("identity.validation.screen").waitForExistence(timeout: 3))

        (0..<4).forEach { _ in element("pin.key.0").tap() }

        XCTAssertTrue(element("actionError.title").waitForExistence(timeout: 3))
        element("actionError.primary").tap()
        XCTAssertTrue(element("transfer.amountScreen").waitForExistence(timeout: 3))
    }

    @MainActor
    private func enterValidTransfer() {
        XCTAssertTrue(element("home.screen").waitForExistence(timeout: 5))
        element("tab.transfer").tap()
        XCTAssertTrue(element("transfer.amountScreen").waitForExistence(timeout: 3))
        element("amount.key.1").tap()
        selectTransferBeneficiary()
        element("transfer.continue").tap()

        XCTAssertTrue(element("identity.validation.screen").waitForExistence(timeout: 3))
        ["1", "2", "3", "4"].forEach { element("pin.key.\($0)").tap() }
    }

    private func launch(authenticated: Bool = false, additionalArguments: [String] = []) {
        app.launchArguments = ["-uiTesting"]
        if authenticated { app.launchArguments.append("-uiTestingAuthenticated") }
        app.launchArguments.append(contentsOf: additionalArguments)
        app.launch()
    }

    private func completeRegistrationStep(
        identifier: String,
        value: String,
        secure: Bool = false
    ) {
        XCTAssertTrue(element("registration.step.\(identifier)").waitForExistence(timeout: 8))
        let input = secure
            ? app.secureTextFields["registration.input"]
            : app.textFields["registration.input"]
        enterText(value, in: input)
        dismissKeyboard()
        element("registration.continue").tap()
    }

    private func enterText(_ value: String, in field: XCUIElement) {
        XCTAssertTrue(field.waitForExistence(timeout: 8))
        field.tap()
        if !app.keyboards.firstMatch.waitForExistence(timeout: 2) {
            field.tap()
        }
        XCTAssertTrue(app.keyboards.firstMatch.waitForExistence(timeout: 2))
        field.typeText(value)
    }

    private func dismissKeyboard() {
        guard app.keyboards.firstMatch.exists else { return }
        app.coordinate(withNormalizedOffset: CGVector(dx: 0.9, dy: 0.2)).tap()
        XCTAssertTrue(app.keyboards.firstMatch.waitForNonExistence(timeout: 2))
    }

    private func selectTransferBeneficiary() {
        let selector = app.buttons["transfer.beneficiarySelector"]
        XCTAssertTrue(selector.waitForExistence(timeout: 3))
        selector.tap()

        let beneficiary = app.buttons["contactCardRow.cell"].firstMatch
        XCTAssertTrue(beneficiary.waitForExistence(timeout: 3))
        beneficiary.tap()

        let continueButton = element("transfer.continue")
        XCTAssertTrue(continueButton.waitForExistence(timeout: 3))
        let enabledPredicate = NSPredicate(format: "isEnabled == true")
        let continueEnabled = XCTNSPredicateExpectation(
            predicate: enabledPredicate,
            object: continueButton
        )
        wait(for: [continueEnabled], timeout: 8)
    }

    private func field(_ identifier: String) -> XCUIElement {
        app.descendants(matching: .any).matching(identifier: identifier).firstMatch
    }

    private func element(_ identifier: String) -> XCUIElement {
        app.descendants(matching: .any).matching(identifier: identifier).firstMatch
    }
}
