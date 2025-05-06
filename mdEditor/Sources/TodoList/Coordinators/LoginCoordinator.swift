//
//  LoginCoordinator.swift
//  TodoList
//
//  Created by D. P. on 05.02.2025.
//

import Foundation
import UIKit

protocol ILoginCoordinator: ICoordinator {
	func showLoginScene()
	func showError(message: String)
}

final class LoginCoordinator: ILoginCoordinator {

	// MARK: - Public properties

	weak var finishDelegate: ICoordinatorFinishDelegate?
	var childCoordinators: [ICoordinator] = []

	// MARK: - Dependencies

	var navigationController: UINavigationController

	// MARK: - Initialization
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	// MARK: - Public methods
	
	func start() {
		showLoginScene()
	}

	func showLoginScene() {
		let viewController = LoginAssembler().assembly { [weak self] result in
			switch result {
			case .success:
				self?.finish()
			case .failure(let error):
				self?.showError(message: error.localizedDescription)
			}
		}
		navigationController.pushViewController(viewController, animated: true)
	}
}

extension LoginCoordinator: IShowError {}
