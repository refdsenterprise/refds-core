import Foundation

public protocol WebSocketClient {
    typealias RequestData = DomainModel
    
    var status: ((WebSocketStatus) -> Void)? { get set }
    var error: ((WebSocketError) -> Void)? { get set }
    var success: ((Data) -> Void)? { get set }
    var repeats: Bool { get }
    
    func webSocket<Request: WebSocketRequest>(request: Request, repeats: Bool) -> Self
    func send(with requestData: RequestData)
    func logger(status: DomainLoggerTag, requestData: RequestData?, message: String?)
    func stopRepeats()
}

public extension WebSocketClient {
    func logger(status: DomainLoggerTag, requestData: RequestData?, message: String?) {
        let json = requestData?.json.content ?? ""
        let content = "\t* Message: \(message ?? "")\n\(json)"
        let domainLogger = DomainLogger(tag: status, date: .current, content: content)
        domainLogger.console()
    }
}
