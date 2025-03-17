import XCTest
@testable import TaskManagerPackage

final class OrderedTaskManagerTests: XCTestCase {
	private let regularTask1 = RegularTask(title: "Regular task 1")
	private let regularTask2 = RegularTask(title: "Regular task 2")
	private let importantTask1 = ImportantTask(title: "Important task 1", taskPriority: .high)
	private let importantTask2 = ImportantTask(title: "Important task 2", taskPriority: .medium)

	func test_gettingSortedListCompletedTasks_sortedListShouldBeRecevied() {
		let sut = makeSut()

		sut.addTask(task: regularTask1)
		sut.addTask(task: importantTask1)
		sut.addTask(task: regularTask2)
		sut.addTask(task: importantTask2)

		XCTAssertEqual(sut.uncompletedTasks()[0].title, importantTask1.title)
		XCTAssertEqual(sut.uncompletedTasks()[2].title, regularTask1.title)

	}

}
// MARK: - TestData

extension OrderedTaskManagerTests {
	func makeSut() -> OrderedTaskManager {
		let taskManager = TaskManager()
		return OrderedTaskManager(taskManager: taskManager)
	}
}
