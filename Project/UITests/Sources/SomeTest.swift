
import XCTest

class SomeTestCase: XCTestCase {

	override func setUp() {
		let app = XCUIApplication()

		app.launchArguments = ["-enableTesting"]

		app.launch()
	}

	func testMethod1() {
		
	}
}
