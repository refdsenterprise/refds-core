import Foundation

public extension ClosedRange {
    static func range(page: Int, amount: Int, count: Int) -> ClosedRange<Int>? {
        let startIndex = amount * (page - 1)
        let endIndex = amount * page
        let rangeInside = (startIndex ... (endIndex - 1))
        var range: ClosedRange<Int>? = count >= endIndex ? rangeInside : nil
        if count - startIndex > 0, range == nil {
            let rangeRemaining = (startIndex ... (count - 1))
            range = rangeRemaining
        }
        return range
    }
}
