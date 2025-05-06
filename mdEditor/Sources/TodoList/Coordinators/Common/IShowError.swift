//
//  IShowError.swift
//  TodoList
//
//  Created by D. P. on 05.02.2025.
//

import Foundation
import UIKit

protocol IShowError {
	func showError(message: String)
}

extension IShowError where Self: ICoordinator {
	func showError(message: String) {
		let alert: UIAlertController
		alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
		let action = UIAlertAction(title: "Ok", style: .default)
		alert.addAction(action)
		navigationController.present(alert, animated: true, completion: nil)
	}
}
