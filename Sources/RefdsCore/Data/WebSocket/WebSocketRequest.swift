import Foundation

public protocol WebSocketRequest {
    associatedtype Response
    
    var webSocketClient: WebSocketClient { get set }
    var webSocketEndpoint: WebSocketEndpoint { get set }
    
    func decode(_ data: Data) throws -> Response
}

public extension WebSocketRequest where Response: Decodable {
    func decode(_ data: Data) throws -> Response {
        guard let decoded: Response = data.asModel() else { throw WebSocketError.invalidResponse(content: data) }
        return decoded
    }
}
