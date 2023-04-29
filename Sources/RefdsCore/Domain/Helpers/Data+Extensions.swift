import Foundation

public extension Data {
    func asModel<T: Decodable>(dateFormat: String? = nil) -> T? {
        let jsonDecoder = JSONDecoder()
        
        if let dateFormat = dateFormat {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = dateFormat
            jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        }
        
        return try? jsonDecoder.decode(T.self, from: self)
    }
}
