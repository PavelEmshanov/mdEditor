import XCTest
@testable import TaskManagerPackage

final class ImportantTaskTests: XCTestCase {
	
	func test_init_withTitle_shoulBeCorrectTitle() {
		let currentDate = Date()
		let sut = ImportantTask(title: title, taskPriority: taskPriorityHigh, createDate: currentDate)

		XCTAssertEqual(sut.title, title, "Не верно работающий инициализатор Наименования при создании Task")

	}

	func test_init_withHighPriority_shoulBeCorrectTaskPriorityAndDeadline() {
		let currentDate = Date()
		let sut = ImportantTask(title: title, taskPriority: taskPriorityHigh, createDate: currentDate)
		
		XCTAssertEqual(sut.taskPriority, taskPriorityHigh, "Инициализирован не корректный приоритет заданияю. Ожидался .high")
		
		XCTAssertEqual(sut.deadLine, Calendar.current.date(byAdding: .day, value: 1, to: currentDate), "Ошибка установки даты дедлайна задания")
	}

	func test_init_withMediumPriority_shoulBeCorrectTaskPriorityAndDeadline() {
		let currentDate = Date()
		let sut = ImportantTask(title: title, taskPriority: taskPriorityMedium, createDate: currentDate)

		XCTAssertEqual(sut.taskPriority, taskPriorityMedium, "Инициализирован не корректный приоритет заданияю. Ожидался .medium")
		
		XCTAssertEqual(sut.deadLine, Calendar.current.date(byAdding: .day, value: 2, to: currentDate), "Ошибка установки даты дедлайна задания")
	}

	func test_init_withLowPriority_shoulBeCorrectTaskPriorityAndDeadline() {
		let currentDate = Date()
		let sut = ImportantTask(title: title, taskPriority: taskPriorityLow, createDate: currentDate)
		
		XCTAssertEqual(sut.taskPriority, taskPriorityLow, "Инициализирован не корректный приоритет заданияю. Ожидался .low")
		
		XCTAssertEqual(sut.deadLine, Calendar.current.date(byAdding: .day, value: 3, to: currentDate), "Ошибка установки даты дедлайна задания")
	}

	func test_init_withCompletedTrue_shoulBeCorrect() {
		let sut = ImportantTask(title: title, taskPriority: taskPriorityMedium)
		sut.completed = true

		XCTAssertTrue(sut.completed, "Задание создано с ошибкой в статусе свойства Completed, ожидалось true")
	}
	
	func test_init_withoutCompleted_propertyCompletedShouldBeFalse() {
		let sut = ImportantTask(title: title, taskPriority: taskPriorityMedium)
		sut.completed = false

		XCTAssertFalse(sut.completed, "Задание созданно с неверным статусом Completed, ожидалось false")
	}
}

// MARK: - TestData

private extension ImportantTaskTests {
	var title: String {
		"Test Task"
	}
}

private extension ImportantTaskTests {
	var taskPriorityHigh: ImportantTask.TaskPriority {
		ImportantTask.TaskPriority.high
	}

	var taskPriorityMedium: ImportantTask.TaskPriority {
		ImportantTask.TaskPriority.medium
	}

	var taskPriorityLow: ImportantTask.TaskPriority {
		ImportantTask.TaskPriority.low
	}
}
