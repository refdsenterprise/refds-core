import Foundation

public protocol HttpRequest {
    associatedtype Response
    
    var httpClient: HttpClient { get set }
    var httpEndpoint: HttpEndpoint { get set }
    
    func decode(_ data: Data) throws -> Response
}

public extension HttpRequest where Response: Decodable {
    func decode(_ data: Data) throws -> Response {
        guard let decoded: Response = data.asModel() else { throw HttpError.invalidResponse(content: data) }
        return decoded
    }
}