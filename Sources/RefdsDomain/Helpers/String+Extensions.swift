import Foundation

public extension String {
    func asDate(withFormat dateFomat: String = "dd/MM/yyyy") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFomat
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
}
