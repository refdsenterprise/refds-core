import Foundation

public protocol HttpRequestProtocol {
    associatedtype Response
    var endpoint: HttpEndpoint { get }
    func decode(_ data: Data) throws -> Response
}

public extension HttpRequestProtocol where Response: Decodable {
    func decode(_ data: Data) throws -> Response {
        guard let decoded: Response = data.asModel() else { throw HttpError.invalidResponse(content: data) }
        return decoded
    }
}
