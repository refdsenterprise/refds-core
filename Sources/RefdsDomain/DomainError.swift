import Foundation

public enum DomainError: Error, CustomStringConvertible {
    case decodedError(type: Decodable.Type)
    case encodedError(type: Encodable.Type)
    case requestError(error: Error)
    
    public var description: String {
        switch self {
        case .decodedError(let decodedType): return "Error on decoded - \(decodedType.self)"
        case .encodedError(let encodedType): return "Error on encoded - \(encodedType.self)"
        case .requestError(let description): return "Error on request - \(description)"
        }
    }
}

// MARK: - DomainLoggerDataSource

extension DomainError: DomainLoggerDataSource {
    public var logger: DomainLogger {
        return DomainLogger(tag: .error, date: .current, content: description)
    }
}
