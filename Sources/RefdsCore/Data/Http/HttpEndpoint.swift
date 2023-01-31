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

extension HttpEndpoint {
    public var urlComponents: URLComponents {
        var  urlComponents = URLComponents()
        urlComponents.scheme = scheme.rawValue
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        return urlComponents
    }
    
    public func urlRequest(url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers?.asDictionary
        guard let body = body else { return urlRequest }
        urlRequest.httpBody = body
        return urlRequest
    }
    
    public var url: URL? { urlComponents.url }
}
