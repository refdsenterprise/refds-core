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
    
    static var randomWord: Self {
        var letters = "";
        for _ in 0 ..< Int.random(in: 4 ... 12) {
            letters += String(format: "%c", Int.random(in: 97 ..< 123))
        }
        return letters
    }
    
    static var randomParagraph: Self {
        var words = "";
        for index in 0 ..< Int.random(in: 10 ... 30) {
            words += (index != 0 ? " " : "") + randomWord
        }
        return words
    }
    
    static var randomText: Self {
        var paragraphs = "";
        for index in 0 ..< Int.random(in: 3 ... 6) {
            paragraphs += (index != 0 ? "\n" : "") + randomParagraph
        }
        return paragraphs
    }
    
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
