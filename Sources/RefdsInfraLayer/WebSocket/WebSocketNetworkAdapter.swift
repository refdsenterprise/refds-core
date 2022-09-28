import Foundation
import RefdsDataLayer

public class WebSocketNetworkAdapter: NSObject, WebSocketClient {
    private var session: URLSession
    
    private var webSocket: URLSessionWebSocketTask?
    private let openConnectionSemaphore = DispatchSemaphore(value: 1)
    private let receiveSemaphore = DispatchSemaphore(value: 1)
    private var currentRequestData: RequestData?
    
    private let receiveQueue = DispatchQueue(
        label: "cedro.streaming.websocket.network.receive",
        qos: .background,
        attributes: .concurrent
    )
    
    private let subscribeQueue = DispatchQueue(
        label: "cedro.streaming.websocket.network.subscribe",
        qos: .background,
        attributes: .concurrent
    )
    
    public override init() {
        self.session = .shared
        super.init()
        session = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
    }
    
    public func webSocket<Request>(request: Request) -> Self where Request : RefdsDataLayer.WebSocketRequest {
        guard let url = makeUrlComponents(endpoint: request.webSocketEndpoint).url else {
            let error = WebSocketError.invalidUrl
            error.logger.console()
            self.error?(error)
            return self
        }
        
        webSocket = session.webSocketTask(with: url)
        webSocket?.resume()
        openConnectionSemaphore.wait()
        return self
    }
    
    public func send(with requestData: RequestData) {
        openConnectionSemaphore.wait()
        currentRequestData = requestData
        subscribeQueue.async { [weak self] in
            guard let self = self else { return }
            let string = requestData.json
            guard string.success else { return self.logger(status: .error, requestData: requestData, message: "Invalida data request") }
            self.webSocket?.send(.string(string.content), completionHandler: { [weak self] error in
                self?.logger(status: .error, requestData: requestData, message: error?.localizedDescription)
            })
        }
        openConnectionSemaphore.signal()
    }
    
    private func makeUrlComponents(endpoint: WebSocketEndpoint) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme.rawValue
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.queryItems
        return urlComponents
    }
    
    private func didReceive() {
        webSocket?.receive(completionHandler: { [weak self] result in
            guard let self = self else { return }
            self.receiveQueue.async { [weak self] in
                guard let self = self else { return }
                self.receiveSemaphore.wait()
                switch result {
                case .success(let message): self.success(didReceive: message)
                case .failure(_): self.failure(message: "WebSocket has failed response")
                }
                self.receiveSemaphore.signal()
            }
        })
    }
    
    private func success(didReceive message: URLSessionWebSocketTask.Message) {
        switch message {
        case .string(let string):
            if let data = string.data(using: .utf8) { success?(data) }
            else { failure(message: "WebSocket failed cast string receive to data") }
        default: failure(message: "WebSocket do not receive a string value")
        }
    }
    
    private func failure(message: String) {
        logger(status: .error, requestData: currentRequestData, message: message)
        error?(.custom(message: message))
    }
}

extension WebSocketNetworkAdapter: URLSessionWebSocketDelegate {
    public func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        status?(.open)
        didReceive()
        openConnectionSemaphore.signal()
    }
    
    public func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        status?(.close)
    }
}
