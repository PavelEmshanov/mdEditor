import ProjectDescription

enum ProjectSettings {
	public static var organizationName: String { "EmshanovPavel" }
	public static var projectName: String { "MdEditor" }
	public static var appVersionName: String { "1.0.0" }
	public static var appVersionBuild: Int { 1 }
	public static var developmentTeam: String { "9TKSP79H7H" }
	public static var targetVersion: String { "15.0" }
	public static var bundleId: String { "\(organizationName).\(projectName)" }
}

let swiftLintScriptBody = "SwiftLint/swiftlint --fix && SwiftLint/swiftlint"
let swiftLintScript = TargetScript.post(script: swiftLintScriptBody, name: "SwiftLint", basedOnDependencyAnalysis: false)

let project = Project(
	name: ProjectSettings.projectName,
	packages: [
		.local(path: .relativeToManifest("../Packages/TaskManagerPackage")),
		.local(path: .relativeToManifest("../Packages/DataStructuresPackage")),
	],
	settings: .settings(
		base: [
			"DEVELOPMENT_TEAM": "\(ProjectSettings.developmentTeam)",
			"MARKETING_VERSION": "\(ProjectSettings.appVersionName)",
			"CURRENT_PROJECT_VERSION": "\(ProjectSettings.appVersionBuild)",
			"DEBUG_INFORMATION_FORMAT": "dwarf-with-dsym"
		],
		defaultSettings: .recommended()
	),
	targets: [
		.target(
			name: ProjectSettings.projectName,
			destinations: .iOS,
			product: .app,
			bundleId: ProjectSettings.bundleId,
			deploymentTargets: .iOS(ProjectSettings.targetVersion),
			infoPlist: .file(path: "Environments/Info.plist"),
			sources: ["Sources/**", "Shared/**"],
			resources: ["Resources/**"],
			scripts: [swiftLintScript],
			dependencies: [.package(product: "DataStructuresPackage"), .package(product: "TaskManagerPackage")]
		),
		.target(
			name: "\(ProjectSettings.projectName)Tests",
			destinations: .iOS,
			product: .unitTests,
			bundleId: "\(ProjectSettings.bundleId)Tests",
			deploymentTargets: .iOS(ProjectSettings.targetVersion),
			sources: ["Tests/Sources/**"],
			dependencies: [.target(name: ProjectSettings.projectName)]
		),
		.target(
			name: "\(ProjectSettings.projectName)UITests",
			destinations: .iOS,
			product: .uiTests,
			bundleId: "\(ProjectSettings.bundleId)UITests",
			deploymentTargets: .iOS(ProjectSettings.targetVersion),
			sources: ["UITests/Sources/**"],
			dependencies: [.target(name: ProjectSettings.projectName)]
		)
	],
	resourceSynthesizers: [.strings()]
)
