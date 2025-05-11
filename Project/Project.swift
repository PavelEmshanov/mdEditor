import ProjectDescription

enum ProjectSettings {
	public static var organizationName: String { "EmshanovPavel" }
	public static var projectName: String { "MdEditor" }
	public static var appVersionName: String { "1.0.0" }
	public static var appVersionBuild: Int { 1 }
	public static var developmentTeam: String { "" }
	public static var targetVersion: String { "15.0" }
	public static var bundleId: String { "\(organizationName).\(projectName)" }
}

let swiftLintScriptBody = "SwiftLint/swiftlint --fix && SwiftLint/swiftlint"
let swiftLintScript = TargetScript.post(script: swiftLintScriptBody, name: "SwiftLint", basedOnDependencyAnalysis: false)

let project = Project(
	name: "MdEditor",
	packages: [
		.local(path: .relativeToManifest("../Package/TaskManagerPackage")),
		.local(path: .relativeToManifest("../Package/DataStructuresPackage")),
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
			name: "MdEditor",
			destinations: .iOS,
			product: .app,
			bundleId: "PavelEmshanov.MdEditor",
			deploymentTargets: .iOS(ProjectSettings.targetVersion),
			infoPlist: .file(path: "Environments/Info.plist"),
			sources: ["Sources/**", "Shared/**"],
			resources: ["Resources/**"],
			scripts: [swiftLintScript],
			dependencies: [.package(product: "DataStructuresPackage"), .package(product: "TaskManagerPackage")]
		),
		.target(
			name: "MdEditorTests",
			destinations: .iOS,
			product: .unitTests,
			bundleId: "PavelEmshanov.MdEditorTests",
			deploymentTargets: .iOS(ProjectSettings.targetVersion),
			sources: ["Tests/**"],
			resources: [],
			dependencies: [.target(name: "MdEditor")]
		),
	],
	resourceSynthesizers: [.strings()]
)
