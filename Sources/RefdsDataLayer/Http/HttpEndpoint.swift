import Foundation

public struct HttpEndpoint {
    public var scheme: HttpScheme
    public var host: String
    public var path: String
    public var method: HttpMethod
    public var queryItems: [URLQueryItem]?
    public var headers: [HttpHeader]?
    public var body: Data?
    
    public init(scheme: HttpScheme, host: String, path: String, method: HttpMethod, queryItems: [URLQueryItem]? = nil, headers: [HttpHeader]? = nil, body: Data? = nil) {
        self.scheme = scheme
        self.host = host
        self.path = path
        self.method = method
        self.queryItems = queryItems
        self.headers = headers
        self.body = body
    }
}
