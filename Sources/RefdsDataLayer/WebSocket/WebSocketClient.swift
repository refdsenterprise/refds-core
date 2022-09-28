import Foundation
import RefdsDomainLayer

public protocol WebSocketClient {
    typealias RequestData = DomainModel
    
    var status: WebSocketStatus { get set }
    
    func webSocket<Request: WebSocketRequest>(request: Request) -> Self
    func send(with requestData: RequestData)
    func logger(status: DomainLoggerTag, requestData: RequestData?, message: String?)
}

public extension WebSocketClient {
    func logger(status: DomainLoggerTag, requestData: RequestData?, message: String?) {
        let json = requestData?.json.content ?? ""
        let content = "\t* Message: \(message ?? "")\n\(json)"
        let domainLogger = DomainLogger(tag: status, date: .current, content: content)
        domainLogger.console()
    }
}
