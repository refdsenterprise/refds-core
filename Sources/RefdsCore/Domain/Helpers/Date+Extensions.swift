import Foundation

public extension Date {
    static var current: Date { return Date() }
    
    func asString(withDateFormat dateFormat: String.DateFormat = .dayMonthYear) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.dateFormat = dateFormat.value
        return dateFormatter.string(from: self)
    }
    
    func formatted(with dateFormat: String.DateFormat = .dayMonthYear) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.dateFormat = dateFormat.value
        return dateFormatter.date(from: self.asString(withDateFormat: dateFormat)) ?? .current
    }
}
