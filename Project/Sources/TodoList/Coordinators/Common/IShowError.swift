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
		alert = UIAlertController(
			title: L10n.IShowError.title,
			message: message,
			preferredStyle: UIAlertController.Style.alert
		)
		let action = UIAlertAction(title: L10n.IShowError.okButton, style: .default)
		alert.addAction(action)
		navigationController.present(alert, animated: true, completion: nil)
	}
}
