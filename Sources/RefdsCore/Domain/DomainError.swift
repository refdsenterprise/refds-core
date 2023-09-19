import Foundation

public enum DomainError: Error, CustomStringConvertible {
    case decodedError(type: Decodable.Type)
    case encodedError(type: Encodable.Type)
    case requestError(error: Error)
    case notFound(type: Any.Type)
    
    public var description: String {
        switch self {
        case .decodedError(let decodedType): return "Error on decoded - \(decodedType.self)"
        case .encodedError(let encodedType): return "Error on encoded - \(encodedType.self)"
        case .requestError(let description): return "Error on request - \(description)"
        case .notFound(let type): return "Error - not found - \(type.self)"
        }
    }
}

// MARK: - DomainLoggerDataSource

extension DomainError: DomainLoggerDataSource {
    public func logger(additionalMessage: String? = nil) -> DomainLogger {
        var content = ""
        if let additionalMessage = additionalMessage { content = additionalMessage }
        content += "\n\t* Response: \(description)"
        return DomainLogger(tag: .error, date: .current, content: content)
    }
}
