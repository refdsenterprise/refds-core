import Foundation

public protocol HttpEndpointProtocol {
    var scheme: HttpScheme { get set }
    var host: String { get set }
    var path: String { get set }
    var method: HttpMethod { get set }
    var queryItems: [URLQueryItem]? { get set }
    var headers: [HttpHeader]? { get set }
    var body: Data? { get set }
}
