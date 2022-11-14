import Foundation

public extension String {
    func asDate(withFormat dateFomat: String = "dd/MM/yyyy") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFomat
        return dateFormatter.date(from: self)
    }
    
    var asDouble: Double? { Double(self) }
    
    var asInt: Int? { Int(self) }
}
