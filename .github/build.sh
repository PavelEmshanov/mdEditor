cd ./Project
tuist install
tuist generate
xcodebuild clean -quiet
xcodebuild build-for-testing\
    -workspace 'MdEditor.xcworkspace' \
    -scheme 'MdEditor' \
    -destination 'platform=iOS Simulator,name=iPhone 16'
