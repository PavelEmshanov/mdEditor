import XCTest
@testable import TaskManagerPackage

final class TaskManagerTests: XCTestCase {

	private let regularTask = RegularTask(title: "Regular task")
	private let importantTask = ImportantTask(title: "Important task", taskPriority: .high)

	func test_addingTask_shouldBeCorectCountTasks() {
		let sut = makeSut()

		XCTAssertEqual(sut.allTasks().count, 2, "Количество добавленных заданий не соответствует, ожидалось 2")
	}

	func test_gettingListCompletedTask_shouldAllCompletedTask() {
		let sut = makeSut()
		sut.allTasks()[0].completed.toggle()

		XCTAssertTrue(sut.completedTasks()[0].completed, "Получено не завершенное задание")
		XCTAssertEqual(sut.completedTasks().count, 1, "Ошибка получения выполненных заданий, не совпадает кол-во задач")
	}

	func test_gettingListUncompletedTask_shouldAllUncompletedTask() {
		let sut = makeSut()
		sut.allTasks()[0].completed.toggle()
		
		XCTAssertFalse(sut.uncompletedTasks()[0].completed, "Получено завершенное задание")
		XCTAssertEqual(sut.uncompletedTasks().count, 1, "Ошибка получения выполненных заданий, не совпадает кол-во задач")
	}

	func test_addNewTask_shouldBeAddedTask() {
		let sut = makeSut()
		sut.addTask(task: RegularTask(title: "New Regular task 1"))
		sut.addTask(task: RegularTask(title: "New Regular task 2"))
		sut.addTask(task: ImportantTask(title: "New Important task 1", taskPriority: .high))


		XCTAssertEqual(sut.allTasks().count, 5, "Количество добавленных заданий не соответствует, ожидалось 5")
	}

	func test_addArrayOfTasks_shouldBeAddedTasks() {
		let sut = makeSut()
		let arrayOfTasks = [
		RegularTask(title: "New Regular task 1"),
		RegularTask(title: "New Regular task 2"),
		ImportantTask(title: "New Important task 1", taskPriority: .high)
		]

		sut.addTasks(tasks: arrayOfTasks)

		XCTAssertEqual(sut.allTasks().count, 5, "Количество добавленных заданий не соответствует, ожидалось 5")
	}

	func test_removeAllTasks_shouldBeDeleted() {
		let sut = makeSut()
		sut.removeTask(task: importantTask)
		
		XCTAssertFalse(sut.allTasks()[0] is ImportantTask, "Удалено не требуемая задача")
	}
}

// MARK: - TestData

extension TaskManagerTests {
	func makeSut() -> TaskManager {
		TaskManager(taskList: [regularTask, importantTask])
	}
}
