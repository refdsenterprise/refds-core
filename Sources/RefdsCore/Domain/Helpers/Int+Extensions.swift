import Foundation

public extension Int {
    var letter: String {
        String(format: "%c", self)
    }
}
