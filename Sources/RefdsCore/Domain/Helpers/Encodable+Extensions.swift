import Foundation

public extension Encodable {
    var json: (success: Bool, content: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
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
    
    func logger(additionalMessage: String? = nil) -> DomainLogger {
        let json = json
        var content = ""
        if let additionalMessage = additionalMessage { content = additionalMessage }
        content += "\n\t* Response: \(json.content.replacingOccurrences(of: "\n", with: "\n\t\t"))"
        return DomainLogger(tag: json.success ? .info : .error, date: .current, content: content)
    }
    
    var asData: Data? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        return try? encoder.encode(self)
    }
    
    var asCSV: String? {
        if let data = self.asData,
           let dict = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]] {
            let keys = Set(dict.flatMap({ $0.keys })).map({ String($0) }).sorted(by: { $0 < $1 })
            let header = keys.map({ $0.uppercased() }).joined(separator: ",") + "\n"
            var body: String = ""
            for element in dict {
                var line: String = ""
                for key in keys {
                    if let value = element[key] {
                        line += "\(String(describing:value)),"
                    }
                }
                if line.last == "," { line.removeLast() }
                line += "\n"
                body += line
            }
            return header + body
        }
        return nil
    }
}
