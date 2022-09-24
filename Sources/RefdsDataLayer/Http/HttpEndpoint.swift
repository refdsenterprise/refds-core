import Foundation

public protocol HttpEndpoint {
    var scheme: HttpScheme { get set }
    var host: String { get set }
    var path: String { get set }
    var method: HttpMethod { get set }
    var queryItems: [URLQueryItem]? { get set }
    var headers: [HttpHeader]? { get set }
    var body: Data? { get set }
}

public extension HttpEndpoint {
    var queryItems: [URLQueryItem]? {
        get { nil }
        set { queryItems = newValue }
    }
    
    var headers: [HttpHeader]? {
        get { nil }
        set { headers = newValue }
    }
    
    var body: Data? {
        get { nil }
        set { body = newValue }
    }
}
