//
//  CreateTaskViewController.swift
//  TodoList
//
//  Created by Kirill Leonov on 04.12.2023.
//

import UIKit

// Всегда старайтесь, чтобы view была описана полностью моделью ViewModel, это облегчает тестирование
// и обработку информации. По сути View должна быть настолько простой, что името только 1 метод для клиента
// `func render(viewModel: LoginModel.ViewModel)`
//
// Тут метод `func taskCreated()` является неизбежным злом и отступлением от правила, из-за Router, который
// имеет связь с View и нам нужно либо добавлять такие методы, либо усложнять ViewModel.
protocol ICreateTaskViewController: AnyObject {
}

class CreateTaskViewController: UIViewController {

	// MARK: - Dependencies

	var interactor: ICreateTaskInteractor?

	// MARK: - Private properties

	private lazy var buttonCreateTask = makeCreateTaskButton()
	private lazy var textFieldTaskName = makeTextField()
	private lazy var segmentedControlTaskType = makeTypeSegmentedControl()
	private lazy var labelPriority = makePriorityLabel()
	private lazy var sliderPriority = makePrioritySlider()

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

private extension CreateTaskViewController {
	@objc
	func createTaskButtonTapped() {
		guard let taskTitle = textFieldTaskName.text, !taskTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
		else { return }

		let request: CreateTaskModel.Request

		if segmentedControlTaskType.selectedSegmentIndex == 0 {
			request = CreateTaskModel.Request.regular(taskTitle)
		} else {
			let task = CreateTaskModel.Request.ImportantTask(
				title: taskTitle,
				priority: Int(sliderPriority.value)
			)
			request = CreateTaskModel.Request.important(task)
		}
		interactor?.createTask(request: request)
	}

	@objc
	func taskTypeChanged() {
		let isImportantTask = segmentedControlTaskType.selectedSegmentIndex == 1

		labelPriority.isHidden = !isImportantTask
		sliderPriority.isHidden = !isImportantTask
	}

	@objc func textFieldDidChange(_ textField: UITextField) {
		let canCreateTask = textFieldTaskName.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
		buttonCreateTask.isEnabled = !(canCreateTask ?? false)
	}
}

// MARK: - Setup UI

private extension CreateTaskViewController {

	func makeCreateTaskButton() -> UIButton {
		let button = UIButton()
		button.configuration = .filled()
		button.configuration?.cornerStyle = .medium
		button.configuration?.baseBackgroundColor = Theme.accentColor
		button.configuration?.title = L10n.CreateTask.createButton
		button.titleLabel?.adjustsFontForContentSizeCategory = true
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}

	func makeTextField() -> UITextField {
		let textField = UITextField()
		textField.backgroundColor = Theme.backgroundColor
		textField.textColor = Theme.mainColor
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.placeholder = L10n.CreateTask.namePlaceholder
		textField.borderStyle = .roundedRect

		textField.font = UIFont.preferredFont(forTextStyle: .callout)
		textField.adjustsFontForContentSizeCategory = true
		return textField
	}

	func makeTypeSegmentedControl() -> UISegmentedControl {
		let items = [
			L10n.CreateTask.normalItem,
			L10n.CreateTask.importantItem
		]
		let segmentedControl = UISegmentedControl(items: items)
		segmentedControl.selectedSegmentTintColor = Theme.backgroundColor
		segmentedControl.translatesAutoresizingMaskIntoConstraints = false
		segmentedControl.selectedSegmentIndex = 0

		return segmentedControl
	}

	func makePriorityLabel() -> UILabel {
		let label = UILabel()
		label.textColor = Theme.mainColor
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = L10n.CreateTask.priorityLabel
		label.isHidden = true
		return label
	}

	func makePrioritySlider() -> UISlider {
		let slider = UISlider()
		slider.tintColor = Theme.accentColor
		slider.translatesAutoresizingMaskIntoConstraints = false
		slider.minimumValue = 0
		slider.maximumValue = 2
		slider.isContinuous = true
		slider.isHidden = true
		return slider
	}

	func setupUI() {
		view.backgroundColor = Theme.backgroundColor
		title = L10n.CreateTask.title
		navigationController?.navigationBar.prefersLargeTitles = true
		buttonCreateTask.isEnabled = false
		
		segmentedControlTaskType.addTarget(self, action: #selector(taskTypeChanged), for: .valueChanged)
		buttonCreateTask.addTarget(self, action: #selector(createTaskButtonTapped), for: .touchUpInside)
		textFieldTaskName.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
	}
}

// MARK: - Layout UI

private extension CreateTaskViewController {

	func layout() {
		view.addSubview(textFieldTaskName)
		view.addSubview(segmentedControlTaskType)
		view.addSubview(labelPriority)
		view.addSubview(sliderPriority)
		view.addSubview(buttonCreateTask)

		NSLayoutConstraint.activate([
			textFieldTaskName.topAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.topAnchor,
				constant: Sizes.Padding.normal
			),
			textFieldTaskName.leadingAnchor.constraint(
				equalTo: view.leadingAnchor,
				constant: Sizes.Padding.normal
			),
			textFieldTaskName.trailingAnchor.constraint(
				equalTo: view.trailingAnchor,
				constant: -Sizes.Padding.normal
			),

			segmentedControlTaskType.topAnchor.constraint(
				equalTo: textFieldTaskName.bottomAnchor,
				constant: Sizes.Padding.normal
			),
			segmentedControlTaskType.centerXAnchor.constraint(equalTo: view.centerXAnchor),

			labelPriority.topAnchor.constraint(
				equalTo: segmentedControlTaskType.bottomAnchor,
				constant: Sizes.Padding.normal
			),
			labelPriority.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Sizes.Padding.normal),

			sliderPriority.topAnchor.constraint(equalTo: labelPriority.bottomAnchor, constant: Sizes.Padding.normal),
			sliderPriority.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Sizes.Padding.normal),
			sliderPriority.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Sizes.Padding.normal),

			buttonCreateTask.topAnchor.constraint(equalTo: sliderPriority.bottomAnchor, constant: Sizes.Padding.double),
			buttonCreateTask.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			
			// Минимальные размеры (защита от слишком маленькой кнопки)
			buttonCreateTask.widthAnchor.constraint(greaterThanOrEqualToConstant: Sizes.L.width),
			buttonCreateTask.heightAnchor.constraint(greaterThanOrEqualToConstant: Sizes.L.height),
			
			// Максимальная ширина (чтобы не растягивалась на весь экран)
			buttonCreateTask.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.8)
			
//			buttonCreateTask.topAnchor.constraint(equalTo: sliderPriority.bottomAnchor, constant: Sizes.Padding.double),
//			buttonCreateTask.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//			buttonCreateTask.widthAnchor.constraint(equalToConstant: Sizes.L.width),
//			buttonCreateTask.heightAnchor.constraint(equalToConstant: Sizes.L.height)
		])
	}
}

extension CreateTaskViewController: ICreateTaskViewController {}
