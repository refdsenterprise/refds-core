import Foundation
import RefdsDomainLayer

public enum HttpError: Error, CustomStringConvertible {
    case noConnectivity(statusCode: Int, url: URL)
    case badRequest(statusCode: Int, url: URL)
    case serverError(statusCode: Int, url: URL)
    case unauthorized(statusCode: Int, url: URL)
    case forbidden(statusCode: Int, url: URL)
    
    public var description: String {
        switch self {
        case .noConnectivity(let statusCode, let url): return "No Connectivity\n*\tStatus Code: \(statusCode)\n*\tURL: \(url.absoluteString)"
        case .badRequest(let statusCode, let url): return "Bad Request - The server cannot or will not process the request due to an apparent client error.\n*\tStatus Code: \(statusCode)\n*\tURL: \(url.absoluteString)"
        case .serverError(let statusCode, let url): return "Server Error - A generic error message, given when an unexpected condition was encountered and no more specific message is suitable.\n*\tStatus Code: \(statusCode)\n*\tURL: \(url.absoluteString)"
        case .unauthorized(let statusCode, let url): return "Unauthorized - Similar to Forbidden, but specifically for use when authentication is required and has failed or has not yet been provided.\n*\tStatus Code: \(statusCode)\n*\tURL: \(url.absoluteString)"
        case .forbidden(let statusCode, let url): return "Forbidden - The request contained valid data and was understood by the server, but the server is refusing action.\n*\tStatus Code: \(statusCode)\n*\tURL: \(url.absoluteString)"
        }
    }
    
    public var logger: DomainLogger {
        return DomainLogger(tag: .error, date: .current, content: description)
    }
}
