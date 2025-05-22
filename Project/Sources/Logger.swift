import Foundation
import os

func log<T>(
	closure: @autoclosure () -> T,
	_ file: String = #file,
	_ function: String = #function,
	_ line: Int = #line
) {
#if DEBUG
	let instance = closure()
	let description: String

	if let debugStringConvertible = instance as? CustomDebugStringConvertible {
		description = debugStringConvertible.debugDescription
	} else {
		description = "\(instance)"
	}

	let file = URL(fileURLWithPath: file).lastPathComponent
	let queue = Thread.isMainThread ? "UI" : "BG"

	os_log("<%s> %s - %s", queue, file, description)
#endif
}
