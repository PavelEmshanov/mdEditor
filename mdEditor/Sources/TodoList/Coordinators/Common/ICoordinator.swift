//
//  Coordinator.swift
//  TodoList
//
//  Created by D. P. on 20.01.2025.
//

import UIKit

protocol ICoordinator: AnyObject {
	var childCoordinators: [ICoordinator] { get set }

	var finishDelegate: ICoordinatorFinishDelegate? { get set }

	var navigationController: UINavigationController { get set }

	func start()

	func finish()
}

extension ICoordinator {
	func finish() {
		childCoordinators.removeAll()
		finishDelegate?.didFinish(coordinator: self)
	}
}
