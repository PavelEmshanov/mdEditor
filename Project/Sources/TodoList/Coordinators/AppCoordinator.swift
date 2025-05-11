//
//  AppCoordinator.swift
//  TodoList
//
//  Created by D. P. on 05.02.2025.
//

import UIKit
import TaskManagerPackage

protocol IAppCoordinator: ICoordinator {
	func showLoginFlow()
	func showTodoListFlow()
}

final class AppCoordinator: IAppCoordinator {

	// MARK: - Public properties

	var childCoordinators: [ICoordinator] = []

	var finishDelegate: ICoordinatorFinishDelegate?

	// MARK: - Dependencies

	var navigationController: UINavigationController

	private let taskManager: ITaskManager

	// MARK: - Private properties
	
	// MARK: - Initialization

	init(navigationController: UINavigationController, taskManager: ITaskManager) {
		self.navigationController = navigationController
		self.taskManager = taskManager
	}

	// MARK: - Public methods
	func start() {
		showLoginFlow()
	}

	func showLoginFlow() {
		let coordinator = LoginCoordinator(navigationController: navigationController)
		childCoordinators.append(coordinator)
		coordinator.finishDelegate = self
		coordinator.start()
	}

	func showTodoListFlow() {
		let coordinator = TodoListCoordinator(navigationController: navigationController, taskManager: taskManager)
		childCoordinators.append(coordinator)
		coordinator.finishDelegate = self
		coordinator.start()
	}
}

// MARK: - ICoordinatorFinishDelegate

extension AppCoordinator: ICoordinatorFinishDelegate {
	func didFinish(coordinator: ICoordinator) {
		if coordinator is ILoginCoordinator {
			showTodoListFlow()
		}
	}
}
