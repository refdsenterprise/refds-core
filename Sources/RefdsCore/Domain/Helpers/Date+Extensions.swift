import Foundation

public extension Date {
    static var current: Date { return Date() }
    
    func asString(withDateFormat dateFormat: String.DateFormat = .dayMonthYear) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat.value
        return dateFormatter.string(from: self)
    }
}
