import Foundation
import RefdsDataLayer

public class NetworkAdapter {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    private func handleError(_ url: URL, statusCode: Int) -> HttpError {
        switch statusCode {
        case 401: return .unauthorized(statusCode: statusCode, url: url)
        case 403: return .forbidden(statusCode: statusCode, url: url)
        case 400...499: return .badRequest(statusCode: statusCode, url: url)
        case 500...599: return .serverError(statusCode: statusCode, url: url)
        default: return .noConnectivity(statusCode: statusCode, url: url)
        }
    }
}

// MARK: - HttpClient
extension NetworkAdapter: HttpClient {
    public func request<Request>(_ request: Request) async -> Result<Request.Response, HttpError> where Request : HttpRequestProtocol {
        guard let url = makeUrlComponents(endpoint: request.httpEndpoint).url else { return .failure(.invalidUrl) }
        let urlRequest = makeUrlRequest(url: url, endpoint: request.httpEndpoint)
        guard let result = try? await session.data(for: urlRequest) else { return .failure(.noConnectivity(statusCode: 0, url: url)) }
        guard let statusCode = (result.1 as? HTTPURLResponse)?.statusCode else { return .failure(.noConnectivity(statusCode: 0, url: url)) }
        guard let decoded = try? request.decode(result.0) else { return .failure(handleError(url, statusCode: statusCode)) }
        return .success(decoded)
    }
    
    private func makeUrlComponents(endpoint: HttpEndpointProtocol) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme.rawValue
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.queryItems
        return urlComponents
    }
    
    private func makeUrlRequest(url: URL, endpoint: HttpEndpointProtocol) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        urlRequest.allHTTPHeaderFields = endpoint.headers?.asDictionary
        guard let body = endpoint.body else { return urlRequest }
        urlRequest.httpBody = body
        return urlRequest
    }
}
