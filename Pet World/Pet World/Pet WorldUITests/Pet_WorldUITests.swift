//
//  Pet_WorldUITests.swift
//  Pet WorldUITests
//
//  Created by Suyog Lanje on 14/07/25.
//

import XCTest

final class Pet_WorldUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    // MARK: - Test Cases

    /// Test if login screen loads with required UI elements
    @MainActor
    func testLoginScreenUIElementsExist() throws {
        XCTAssertTrue(app.textFields["Enter your email"].exists)
        XCTAssertTrue(app.secureTextFields["Enter your password"].exists)
        XCTAssertTrue(app.buttons["Login"].exists)
        XCTAssertTrue(app.buttons["Forgot Password?"].exists)
        XCTAssertTrue(app.buttons["Create Account"].exists)
    }

    /// Test invalid email shows alert
    @MainActor
    func testInvalidEmailShowsAlert() {
        let emailField = app.textFields["Enter your email"]
        let passwordField = app.secureTextFields["Enter your password"]
        let loginButton = app.buttons["Login"]

        emailField.tap()
        emailField.typeText("invalid_email")
        passwordField.tap()
        passwordField.typeText("12345678")
        loginButton.tap()

        let alert = app.alerts["Invalid Email"]
        XCTAssertTrue(alert.waitForExistence(timeout: 2))
        XCTAssertTrue(alert.staticTexts["Please enter a valid email address."].exists)
        alert.buttons["OK"].tap()
    }

    /// Test empty password shows alert
    @MainActor
    func testEmptyPasswordShowsAlert() {
        let emailField = app.textFields["Enter your email"]
        let loginButton = app.buttons["Login"]

        emailField.tap()
        emailField.typeText("test@example.com")
        loginButton.tap()

        let alert = app.alerts["Invalid Password"]
        XCTAssertTrue(alert.waitForExistence(timeout: 2))
        alert.buttons["OK"].tap()
    }

    /// Test forgot password button opens alert
    @MainActor
    func testForgotPasswordAlertAppears() {
        app.buttons["Forgot Password?"].tap()
        let alert = app.alerts["Forgot Password"]
        XCTAssertTrue(alert.waitForExistence(timeout: 2))
        alert.buttons["OK"].tap()
    }

    /// Test navigation to create account screen
    @MainActor
    func testCreateAccountNavigation() {
        app.buttons["Create Account"].tap()
        // You can add an identifier to titleLabel in `NewAccountViewController` to verify this:
        let createLabel = app.staticTexts["Create Account"]
        XCTAssertTrue(createLabel.waitForExistence(timeout: 2))
    }
}
