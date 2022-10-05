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
    public func logger(additionalMessage: String?) -> DomainLogger {
        var content = ""
        if let additionalMessage = additionalMessage { content = additionalMessage }
        content += "\n\t* Response: \(description)"
        return DomainLogger(tag: .error, date: .current, content: content)
    }
}
