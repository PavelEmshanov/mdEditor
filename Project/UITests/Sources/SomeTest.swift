
import XCTest
@testable import MdEditor

final class SomeTestCase: XCTestCase {

	private let app = XCUIApplication()

	override func setUp() {

		app.launchArguments = ["-enableTesting"]
		app.launchArguments += ["-AppleLanguages", "(en)"]
		app.launch()
	}

	func testLoginWithInvalidCredentials() throws {

		// Входим с неправильными учетными данными
		let usernameTextField = app.textFields["Login"]
		let passwordTextField = app.secureTextFields["Password"]
		let loginButton = app.buttons["Login"]
		
		usernameTextField.tap()
		usernameTextField.typeText("invalidUsername")

		passwordTextField.tap()
		passwordTextField.typeText("invalidPassword")
		
		loginButton.tap()

		// Обработка всплывающего окна с ошибкой
		addUIInterruptionMonitor(withDescription: "Invalid credentials") { (alert) -> Bool in
			let errorMessage = alert.staticTexts["Error auth."]
			XCTAssertTrue(errorMessage.exists, "Expecred error messahe not found")

			let okButton = alert.buttons["Ok"]
			okButton.tap()
			return true
		}

		// Ждем, чтобы обработчик мог сработать
		XCTAssertTrue(app.wait(for: .runningForeground, timeout: 5))
		
	}

//	func testMethod1() {
//
//		app.activate()
////		app.textFields[AccessibilityIdentifier.textFieldLogin.rawValue].tap()
////		app/*@START_MENU_TOKEN@*/.keys["A"]/*[[".otherElements.keys[\"A\"]",".keys[\"A\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
////		app/*@START_MENU_TOKEN@*/.keys["d"]/*[[".otherElements.keys[\"d\"]",".keys[\"d\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
////		app/*@START_MENU_TOKEN@*/.keys["m"]/*[[".otherElements.keys[\"m\"]",".keys[\"m\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
////		app/*@START_MENU_TOKEN@*/.keys["i"]/*[[".otherElements.keys[\"i\"]",".keys[\"i\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
////		app/*@START_MENU_TOKEN@*/.keys["n"]/*[[".otherElements.keys[\"n\"]",".keys[\"n\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//		
//		let secureTextField = app.secureTextFields[AccessibilityIdentifier.textFieldPassword.rawValue]
//		secureTextField.tap()
////		app/*@START_MENU_TOKEN@*/.keys["p"]/*[[".otherElements.keys[\"p\"]",".keys[\"p\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
////		app/*@START_MENU_TOKEN@*/.keys["a"]/*[[".otherElements.keys[\"a\"]",".keys[\"a\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
////		app/*@START_MENU_TOKEN@*/.keys["s"]/*[[".otherElements.keys[\"s\"]",".keys[\"s\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//	
//		app.buttons[AccessibilityIdentifier.buttonLogin.rawValue].tap()
//
////		app.alerts["Error"].buttons["Ok"].tap()
//	}
}
