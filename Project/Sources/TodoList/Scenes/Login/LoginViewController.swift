//
//  LoginViewController.swift
//  TodoList
//
//  Created by Kirill Leonov on 14.11.2023.
//

import UIKit

// Всегда старайтесь, чтобы view была описана полностью моделью ViewModel, это облегчает тестирование
protocol ILoginViewController: AnyObject {}

final class LoginViewController: UIViewController {

	// MARK: - Dependencies

	var interactor: ILoginInteractor?

	// MARK: - Private properties

	private lazy var textFieldLogin: UITextField = makeTextField(
		accessibilityIdentifier: AccessibilityIdentifier.textFieldLogin.rawValue
	)
	private lazy var textFieldPass: UITextField = makeTextField(
		accessibilityIdentifier: AccessibilityIdentifier.textFieldPassword.rawValue
	)
	private lazy var buttonLogin: UIButton = makeButtonLogin(
		accessibilityIdentifier: AccessibilityIdentifier.buttonLogin.rawValue
	)

	private var constraints = [NSLayoutConstraint]()

	// MARK: - Initialization

	init() {
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		layout()
	}
}

// MARK: - Actions

private extension LoginViewController {
	@objc
	func login() {
		if let email = textFieldLogin.text, let password = textFieldPass.text {
			let request = LoginModel.Request(login: email, password: password)
			interactor?.login(request: request)
		}
	}
}

// MARK: - Setup UI

private extension LoginViewController {

	func makeTextField(accessibilityIdentifier: String) -> UITextField {
		let textField = UITextField()

		textField.backgroundColor = Theme.backgroundColor
		textField.textColor = Theme.mainColor
		textField.layer.borderWidth = Sizes.borderWidth
		textField.layer.cornerRadius = Sizes.cornerRadius
		textField.layer.borderColor = UIColor.lightGray.cgColor
		textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: Sizes.Padding.half, height: textField.frame.height))
		textField.leftViewMode = .always
		textField.translatesAutoresizingMaskIntoConstraints = false

		textField.font = UIFont.preferredFont(forTextStyle: .body)
		textField.adjustsFontForContentSizeCategory = true

		textField.accessibilityIdentifier = accessibilityIdentifier

		return textField
	}

	func makeButtonLogin(accessibilityIdentifier: String) -> UIButton {
		let button = UIButton()

		button.configuration = .filled()
		button.configuration?.cornerStyle = .medium
		button.configuration?.baseBackgroundColor = Theme.accentColor
		button.configuration?.title = L10n.Authorization.loginButton
		button.addTarget(self, action: #selector(login), for: .touchUpInside)

		button.translatesAutoresizingMaskIntoConstraints = false

		button.accessibilityIdentifier = accessibilityIdentifier

		return button
	}

	func setupUI() {
		view.backgroundColor = Theme.backgroundColor
		title = L10n.Authorization.title
		navigationController?.navigationBar.prefersLargeTitles = true

		// Кастомная конфигурация наших полей
		textFieldLogin.placeholder = L10n.Authorization.loginPlaceholder
		textFieldPass.placeholder = L10n.Authorization.password
		textFieldPass.isSecureTextEntry = true

		view.addSubview(textFieldLogin)
		view.addSubview(textFieldPass)
		view.addSubview(buttonLogin)
	}
}

// MARK: - Layout UI

private extension LoginViewController {

	func layout() {
		NSLayoutConstraint.deactivate(constraints)

		let newConstraints = [
			textFieldLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			textFieldLogin.topAnchor.constraint(equalTo: view.topAnchor, constant: thirdOfTheScreen),
			textFieldLogin.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Sizes.L.widthMultiplier),
			textFieldLogin.heightAnchor.constraint(equalToConstant: Sizes.L.height),

			textFieldPass.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			textFieldPass.topAnchor.constraint(equalTo: textFieldLogin.bottomAnchor, constant: Sizes.Padding.normal),
			textFieldPass.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Sizes.L.widthMultiplier),
			textFieldPass.heightAnchor.constraint(equalToConstant: Sizes.L.height),

			buttonLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			buttonLogin.topAnchor.constraint(equalTo: textFieldPass.bottomAnchor, constant: Sizes.Padding.double),
			buttonLogin.widthAnchor.constraint(equalToConstant: Sizes.L.width),
			buttonLogin.heightAnchor.constraint(equalToConstant: Sizes.L.height)
		]

		NSLayoutConstraint.activate(newConstraints)

		constraints = newConstraints
	}

	var thirdOfTheScreen: Double {
		return view.bounds.size.height / 3.0
	}
}

// MARK: - ILoginViewController

extension LoginViewController: ILoginViewController {}
