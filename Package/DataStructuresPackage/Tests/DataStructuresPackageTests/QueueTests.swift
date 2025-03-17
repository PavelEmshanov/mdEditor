import XCTest
@testable import DataStructuresPackage

final class QueueTests: XCTestCase {
	func test_init_emptyQueue_shouldBeEmpty() {
		let sut = Queue<Int>()
		
		XCTAssertTrue(sut.isEmpty, "Созданная очередь не пуста")
	}

	func test_enqueue_twoValues_shouldBeCorrectCountAndFirstValue() {
		var sut = Queue<Int>()

		sut.enqueue(1)
		sut.enqueue(2)

		XCTAssertEqual(sut.count, 2, "Количество элементов в очереди не корректно, ожидалось 2")
		XCTAssertEqual(sut.peek, 1, "Первый элемент очереди не корректный")
	}

	func test_dequeue_shouldBeCorrectCountAndValue() {
		var sut = Queue<Int>()
		sut.enqueue(1)
		sut.enqueue(2)

		let returnsValue = sut.dequeue()

		XCTAssertEqual(returnsValue, 1, "Очередь вернула некорректное значение")
		XCTAssertEqual(sut.count, 1, "Количество поставленных в очередь значений не верно.")
		XCTAssertEqual(sut.peek, 2, "Первый элемент в очереди оказался некорректным.")
	}

	func test_peak_valueShouldBeCorrect() {
		var sut = Queue<Int>()
		sut.enqueue(1)
		sut.enqueue(2)

		let returnsValue = sut.peek

		XCTAssertEqual(returnsValue, 1, "Очередь вернула некорректное значение")
	}
}
