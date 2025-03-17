import XCTest
@testable import TaskManagerPackage

final class TaskTests: XCTestCase {

	func test_init_withTitleAndCompleted_shoulBeCorrect() {
		let sut = Task(title: title, completed: true)

		XCTAssertEqual(sut.title, title, "Не верно работающий инициализатор Наименования при создании Task")

		XCTAssertTrue(sut.completed, "Задание создано с ошибкой в статусе свойства Completed, ожидалось True")
	}

	func test_init_withTitleAndNotCompleted_shoulBeCorrect() {
		let sut = Task(title: title, completed: false)
		
		XCTAssertEqual(sut.title, title, "Не верно работающий инициализатор Наименования при создании Task")
		
		XCTAssertFalse(sut.completed, "Задание создано с ошибкой в статусе свойства Completed, ожидалось False")
	}

	func test_init_withoutCompleted_propertyCompletedShouldBeFalse() {
		let sut = Task(title: title)

		XCTAssertFalse(sut.completed, "Задание созданно с неверным статусом Completed")
	}

}

// MARK: - TestData

private extension TaskTests {
	var title: String {
		"Test Task"
	}
}
