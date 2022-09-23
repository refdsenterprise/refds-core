import Foundation

public extension Encodable {
    var json: (success: Bool, content: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        guard let data = try? encoder.encode(self),
              let string = String(data: data, encoding: .utf8)
        else {
            let string = DomainError.encodedError(type: Self.self).description
            return (success: false, content: string)
        }
        return (success: true, content: string)
    }
    
    var logger: DomainLogger {
        let json = json
        if json.success { return DomainLogger(tag: .info, date: .current, content: json.content) }
        else { return DomainLogger(tag: .error, date: .current, content: json.content) }
    }
}
