//
//  LoginPresenter.swift
//  TodoList
//
//  Created by Kirill Leonov on 04.12.2023.
//

import Foundation

typealias LoginResultClosure = (Result<Void, LoginError>) -> Void

protocol ILoginPresenter {
	func present(responce: LoginModel.Response)
}

class LoginPresenter: ILoginPresenter {

	// MARK: - Dependencies

	private weak var viewController: ILoginViewController?

	private var loginResultClosure: LoginResultClosure?

	// MARK: - Initialization

	init(viewController: ILoginViewController, loginResultClosure: LoginResultClosure?) {
		self.viewController = viewController
		self.loginResultClosure = loginResultClosure
	}

	// MARK: - Public methods

	func present(responce: LoginModel.Response) {
		loginResultClosure?(responce.result)
	}
}

extension LoginError: LocalizedError {
	var errorDescription: String? {
		switch self {
		case .wrongPassword:
			return L10n.LoginPresenter.wrongPassword
		case .wrongLogin:
			return L10n.LoginPresenter.wrongLogin
		case .emptyFields:
			return L10n.LoginPresenter.emptyFields
		case .errorAuth:
			return L10n.LoginPresenter.errorAuth
		}
	}
}
