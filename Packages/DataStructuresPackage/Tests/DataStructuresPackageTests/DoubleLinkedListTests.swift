import XCTest
@testable import DataStructuresPackage

final class DoubleeLinkedListTests: XCTestCase {
	func test_init_woElements_shouldBeEmpty() {
		let sut = DoubleLinkedList<Int>()

		XCTAssertTrue(sut.isEmpty, "Список создан не пустым")
	}

	func test_init_withOneElement_listShouldBeOneElement() {
		let testValue = 10
		let sut = DoubleLinkedList<Int>(testValue)

		XCTAssertEqual(sut.count, 1, "Список имеет не верное количество элементов, ожидается 1 элемент")
	}

	func test_pushElements_twoElements_countShouldBeCorrect() {
		var sut = DoubleLinkedList<Int>()

		sut.push(1)
		sut.push(2)

		XCTAssertEqual(sut.value(at: 0), 2, "Функция добавляет каждый новый элемент не в начало списка")
		XCTAssertEqual(sut.count, 2, "Не верное количество элементов в списке")
	}

	func test_appendElements_twoElements_countShouldBeCorrect() {
		var sut = DoubleLinkedList<Int>()

		sut.append(1)
		sut.append(2)

		XCTAssertEqual(sut.tailValue, 2, "Функция добавляет каждый новый элемент не в конец списка")
		XCTAssertEqual(sut.count, 2, "Не верное количество элементов в списке")
	}

	func test_insertElement_valueShouldBeCorrect() {
		var sut = DoubleLinkedList<Int>(1)
		sut.push(2)

		sut.insert(5, after: 0)

		XCTAssertEqual(sut.value(at: 1), 5, "Вставленно по некорректному индексу")
	}

	func test_pop_valueAndCountShouldBeCorrect() {
		var sut = DoubleLinkedList<Int>(1)
		sut.append(2)

		let removableValue = sut.pop()

		XCTAssertEqual(removableValue, 1, "Извлеченное значение не корректено")
		XCTAssertEqual(sut.count, 1, "Удаление не произведено, не корректное количество элементов в списке")
	}

	func test_removeLast_valueAndCountShouldBeCorrect() {
		var sut = DoubleLinkedList<Int>(1)
		sut.append(2)

		let removableValue = sut.removeLast()

		XCTAssertEqual(removableValue, 2, "Извлеченное значение не корректено")
		XCTAssertEqual(sut.count, 1, "Удаление не произведено, не корректное количество элементов в списке")
	}

	func test_removeAfter_valueAndCountShouldBeCorrect() {
		var sut = DoubleLinkedList<Int>(1)
		sut.append(2)
		sut.append(3)
		
		let removableValue = sut.remove(after: 0)
		
		XCTAssertEqual(removableValue, 2, "Извлеченное значение не корректено")
		XCTAssertEqual(sut.count, 2, "Удаление не произведено, не корректное количество элементов в списке")
	}

	func test_value_valueShouldBeCorrect() {
		var sut = DoubleLinkedList<Int>(1)
		sut.append(2)
		sut.append(3)

		let valueAtIndex = sut.value(at: 1)

		XCTAssertEqual(valueAtIndex, 2, "Извлеченное значение не корректено")
	}
}
