//
//  ICoordinatorFinishDelegate.swift
//  TodoList
//
//  Created by D. P. on 05.02.2025.
//

import Foundation

protocol ICoordinatorFinishDelegate: AnyObject {
	func didFinish(coordinator: ICoordinator)
}
