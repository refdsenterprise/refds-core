import Foundation
import RefdsDomain

public enum WebSocketError: Error, CustomStringConvertible {
    case invalidUrl
    case invalidResponse(content: Data)
    case custom(message: String)
    
    public var description: String {
        switch self {
        case .invalidUrl: return "Invalid URL"
        case let .invalidResponse(content): return "Invalid Response\n*\tReceived Response: \(String(data: content, encoding: .utf8) ?? "")"
        case let .custom(message): return "\(message)"
        }
    }
}

// MARK: - DomainLoggerDataSource

extension WebSocketError: DomainLoggerDataSource {
    public var logger: DomainLogger {
        return DomainLogger(tag: .error, date: .current, content: description)
    }
}
