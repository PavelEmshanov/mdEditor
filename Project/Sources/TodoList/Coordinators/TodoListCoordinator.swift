//
//  TodoListCoordinator.swift
//  TodoList
//
//  Created by D. P. on 05.02.2025.
//

import Foundation
import UIKit
import TaskManagerPackage

protocol ITodoListCoordinator: ICoordinator {
	func showTodoListSCene()
	func showCreateTaskScene()
}

class TodoListCoordinator: ITodoListCoordinator {
	// MARK: - Public properties

	var finishDelegate: ICoordinatorFinishDelegate?
	var childCoordinators: [ICoordinator] = []

	// MARK: - Dependencies
	
	var navigationController: UINavigationController

	private let taskManager: ITaskManager

	// MARK: - Initialization

	init(navigationController: UINavigationController, taskManager: ITaskManager) {
		self.navigationController = navigationController
		self.taskManager = taskManager
	}

	// MARK: - Public methods

	func start() {
		showTodoListSCene()
	}

	func showTodoListSCene() {
		let viewController = TodoListAssembler(
			taskManager: taskManager
		).assembly { [weak self] in
			self?.showCreateTaskScene()
		}
		navigationController.pushViewController(viewController, animated: true)
	}

	func showCreateTaskScene() {
		let viewController = CreateTaskAssembler(taskManager: taskManager).assembly {
			self.navigationController.popViewController(animated: true)
		}
		navigationController.pushViewController(viewController, animated: true)
	}
}
