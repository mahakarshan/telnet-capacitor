import Foundation

@objc public class telentConnection: NSObject {
    @objc public func echo(_ value: String) -> String {
        print(value)
        return value
    }
}
