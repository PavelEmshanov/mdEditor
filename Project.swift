import ProjectDescription

enum ProjectSettings {
	public static var organizationName: String { "EmshanovPavel" }
	public static var projectName: String { "mdEditor" }
	public static var appVersionName: String { "1.0.0" }
	public static var appVersionBuild: Int { 1 }
	public static var developmentTeam: String { "" }
	public static var targetVersion: String { "15.0" }
	public static var bundleId: String { "\(organizationName).\(projectName)" }
}

let swiftLintScriptBody = "SwiftLint/swiftlint --fix && SwiftLint/swiftlint"
let swiftLintScript = TargetScript.post(script: swiftLintScriptBody, name: "SwiftLint", basedOnDependencyAnalysis: false)

let project = Project(
	name: "mdEditor",
	packages: [
		.local(path: .relativeToManifest("../mdEditor/Package/TaskManagerPackage")),
		.local(path: .relativeToManifest("../mdEditor/Package/DataStructuresPackage")),
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
			name: "mdEditor",
			destinations: .iOS,
			product: .app,
			bundleId: "PavelEmshanov.mdEditor",
			deploymentTargets: .iOS(ProjectSettings.targetVersion),
			infoPlist: "Environments/Info.plist",
			sources: ["mdEditor/Sources/**", "mdEditor/Shared/**"],
			resources: ["mdEditor/Resources/**"],
			scripts: [swiftLintScript],
			dependencies: [.package(product: "DataStructuresPackage"), .package(product: "TaskManagerPackage")]
		),
		.target(
			name: "mdEditorTests",
			destinations: .iOS,
			product: .unitTests,
			bundleId: "PavelEmshanov.mdEditorTests",
			deploymentTargets: .iOS(ProjectSettings.targetVersion),
			sources: ["mdEditor/Tests/**"],
			resources: [],
			dependencies: [.target(name: "mdEditor")]
		),
	]
)
