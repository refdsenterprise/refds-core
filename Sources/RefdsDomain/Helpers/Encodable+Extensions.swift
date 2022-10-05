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
    
    func logger(additionalMessage: String?) -> DomainLogger {
        let json = json
        var content = ""
        if let additionalMessage = additionalMessage { content = additionalMessage }
        content += "\n\t* Response: \(json.content.replacingOccurrences(of: "\n", with: "\n\t\t"))"
        return DomainLogger(tag: json.success ? .info : .error, date: .current, content: content)
    }
    
    var asData: Data? {
        return try? JSONEncoder().encode(self)
    }
}
