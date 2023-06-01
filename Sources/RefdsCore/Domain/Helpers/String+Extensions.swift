import Foundation

public extension String {
    func asDate(withFormat dateFomat: String.DateFormat = .dayMonthYear) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = dateFomat.value
        return dateFormatter.date(from: self)
    }
    
    var asDouble: Double? {
        if let double = Double(self) {
            return double
        } else {
            let string = self.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: ",", with: ".")
            return Double(string)
        }
    }
    
    var asInt: Int? { Int(self) }
    
    enum DateFormat {
        case dayMonthYear
        case monthYear
        case weekMonthYear
        case custom(String)
        
        public var value: String {
            switch self {
            case .dayMonthYear: return "dd/MM/yyyy"
            case .monthYear: return "MM/yyyy"
            case .weekMonthYear: return "EEEE/MM/yyyy"
            case .custom(let dateFormat): return dateFormat
            }
        }
    }
}
