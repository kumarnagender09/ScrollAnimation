# ScrollAnimation

A small SwiftUI demo app that demonstrates a collapsible header and list scroll animation.

The app shows a green header with a search input and an action button. As the list below scrolls, the header grows and shrinks between a configurable min/max height, and snaps open when the top of the list is visible. This repository is a compact example of handling scroll offsets in SwiftUI using a named coordinate space and GeometryReader.

## Features
- Collapsible top header that animates between min/max heights
- Snap behavior when the top item becomes fully visible
- Simple list of sample items to demonstrate scrolling behavior
- Custom rounded corner shape for polished visuals

## Requirements
- Xcode 14+ (Xcode 15 recommended)
- macOS with Xcode Command Line Tools
- iOS 15.6+ (deployment target set in project)
- Swift 5

## Project structure
- `ScrollAnimation/` - app source files
	- `ContentView.swift` - main view that contains the header + list and the scroll animation logic
	- `ScrollAnimationApp.swift` - application entry point
	- `Assets.xcassets` - app icons and accent color
- `ScrollAnimation.xcodeproj/` - the Xcode project
- `ScrollAnimationTests/` - unit test scaffold (uses Swift 'Testing')
- `ScrollAnimationUITests/` - UI tests using XCTest

## How it works (short)
- The header's height is controlled by a `@State` property called `headerHeight`.
- The scrollable list is wrapped in a `ScrollView` that uses a named `coordinateSpace`.
- A `GeometryReader` inside the list captures the minY offset of the content in the named coordinate space.
- The `updateHeaderHeight(offset:)` function uses the difference between the current and previous offset (delta) to increase/decrease the header height while clamping between `minHeight` and `maxHeight`.
- The header snaps to max height when the top item is fully visible (offset >= 0).
- `RoundedCorner` is a small custom `Shape` that rounds specific corners for the header and list container.

## Run the app
1. Open the project in Xcode:

	 - `open ScrollAnimation.xcodeproj`
	 - Or open `ScrollAnimation.xcworkspace` if you use a workspace (the workspace file exists in the repo)

2. Choose a simulator (iPhone 14/15 or other device) and press the Run button (or Cmd+R).

3. Interact with the list to see how the header grows and shrinks while scrolling. Try fast scrolls — the header will snap open when the first item becomes fully visible.

## Run the app from the command line (optional)
If you prefer command line builds, you can use `xcodebuild`. Example:

```
xcodebuild -project ScrollAnimation.xcodeproj -scheme ScrollAnimation -destination 'platform=iOS Simulator,name=iPhone 14' build
```

Run the tests:

```
xcodebuild -project ScrollAnimation.xcodeproj -scheme ScrollAnimation -destination 'platform=iOS Simulator,name=iPhone 14' test
```

Note: Running `xcodebuild` may require valid signing or a simulator target: you can change the destination simulator name to an installed simulator on your machine.

## Tests
- `ScrollAnimationTests` contains a simple example scaffold that uses the Swift `Testing` library. `ScrollAnimationUITests` uses XCTest for UI-level testing.

## Troubleshooting
- If the project fails to open or build due to the iOS deployment target, make sure your environment matches the `IPHONEOS_DEPLOYMENT_TARGET` in Xcode (the app target uses `15.6`). Some test targets in the `project.pbxproj` may show `26.0` for tools version — set your deployment target for test targets to a valid iOS version if needed.
- If there are code-signing issues for device builds, choose a team in the project's Signing & Capabilities or run on Simulator.

## Extending / Contribution notes
- Replace the placeholder search text binding `TextField("Search", text: .constant(""))` with `@State var q: String` and filter the `ForEach(1...50)` items to try search and live filtering.
- Add sample data models and replace the simple string items with real content.
- If you plan to publish or distribute, add a license and update the App ID and provisioning settings.

## License
This project does not contain a license file. If you want to change the license, add an appropriate `LICENSE` file (MIT/Apache-2.0/etc.).

## Credits
- Author: Nagender Kumar
- GitHub: kumarnagender09

If you want changes to the README (different target iOS version, more structure explanation, or a sample screenshot), tell me and I’ll update it.
