cd ./Project
xcodebuild test-without-building \
	-workspace 'MdEditor.xcworkspace' \
	-scheme 'MdEditor' \
	-destination 'platform=i0S Simulator, name=iPhone 14 Pro'
