//
//  SceneDelegate.swift

 import UIKit
 import TaskManagerPackage

 class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	// MARK: - Public properties

	var window: UIWindow?

	// MARK: - Dependencies

	private var orderedTaskManager: OrderedTaskManager!
	private var appCoordinator: IAppCoordinator!

	// MARK: - Lifecycle

	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		guard let scene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: scene)

		let navigationController = UINavigationController()

		let repository = TaskRepositoryStub()
		orderedTaskManager = OrderedTaskManager(taskManager: TaskManager())
		orderedTaskManager.addTasks(tasks: repository.getTasks())

		appCoordinator = AppCoordinator(navigationController: navigationController, taskManager: orderedTaskManager)

		window.rootViewController = navigationController
		window.makeKeyAndVisible()

		appCoordinator.start()

		self.window = window
	}
 }
