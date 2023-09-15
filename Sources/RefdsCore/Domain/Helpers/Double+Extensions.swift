import Foundation

public extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    var currency: String {
        if let code = Locale.current.currencyCode {
            return self.formatted(.currency(code: code))
        }
        return String(format: "%.2f", self)
    }
    
    var distance: String {
        let current = self * 1000
        let km = Int(current / 1000)
        let m = Int(current - (Double(km) * 1000))
        return "\(km)km \(m)m"
    }
}
