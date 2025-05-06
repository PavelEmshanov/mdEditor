//
//  CreateTaskPresenter.swift
//  TodoList
//
//  Created by Kirill Leonov on 05.12.2023.
//

import Foundation

protocol ICreateTaskPresenter {

	/// Уведомление, что задание создано.
	func taskCreated()
}

final class CreateTaskPresenter: ICreateTaskPresenter {

	// MARK: - Dependencies

	private weak var viewController: ICreateTaskViewController! // swiftlint:disable:this implicitly_unwrapped_optional

	private var createTaskClosure: () -> Void
	// MARK: - Initialization

	init(viewController: ICreateTaskViewController, createTaskClosure: @escaping () -> Void) {
		self.viewController = viewController
		self.createTaskClosure = createTaskClosure
	}

	// MARK: - Public methods

	func taskCreated() {
		createTaskClosure()
	}
}
