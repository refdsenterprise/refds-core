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
    
    func reduceScale(to places: Int) -> Double {
        let multiplier = pow(10, Double(places))
        let newDecimal = multiplier * self
        let truncated = Double(Int(newDecimal))
        let originalDecimal = truncated / multiplier
        return originalDecimal
    }
    
    var formatted: String {
//        let num = abs(self)
//        let sign = self < 0 ? "-" : ""
//        
//        switch num {
//        case 1_000_000_000...:
//            return String(format: "\(sign)%.2fB", (num / 1_000_000_000).reduceScale(to: 1))
//        case 1_000_000...:
//            return String(format: "\(sign)%.2fM", (num / 1_000_000).reduceScale(to: 1))
//        case 1_000...:
//            return String(format: "\(sign)%.2fK", (num / 1_000).reduceScale(to: 1))
//        case 0...:
//            return String(format: "%.2f", self)
//        default:
//            return String(format: "%.2f", self)
//        }
        String(format: "%.2f", self)
    }
}
