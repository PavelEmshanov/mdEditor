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

private var swiftLintTargetScript: TargetScript {
	let swiftLintScriptString = """
  export PATH="$PATH:/opt/homebrew/bin"
  if which swiftlint > /dev/null; then
  swiftlint
  else
  echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
  exit 1
  fi
  """
	
	return TargetScript.pre(
		script: swiftLintScriptString,
		name: "Run SwiftLint",
		basedOnDependencyAnalysis: false
	)
}

private let scripts: [TargetScript] = [
	swiftLintTargetScript
]



let project = Project(
	name: "mdEditor",
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
			infoPlist: .extendingDefault(
				with: [
					"UILaunchScreen": [
						"UIColorName": "",
						"UIImageName": "",
					],
				]
			),
			sources: ["mdEditor/Sources/**"],
			resources: ["mdEditor/Resources/**"],
			scripts: scripts,
			dependencies: [
				.package(product: "mdEditor", type: .macro)
			]
		),
		.target(
			name: "mdEditorTests",
			destinations: .iOS,
			product: .unitTests,
			bundleId: "io.tuist.mdEditorTests",
			infoPlist: .default,
			sources: ["mdEditor/Tests/**"],
			resources: [],
			dependencies: [.target(name: "mdEditor")]
		),
	]
)
