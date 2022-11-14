import Foundation
import RefdsData

public class HttpNetworkAdapter: HttpClient {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func request<Request>(_ request: Request) async -> Result<Request.Response, HttpError> where Request : HttpRequest {
        guard let url = request.httpEndpoint.url else {
            let error = HttpError.invalidUrl
            error.logger(additionalMessage: makeAdditionalMessage(withEndpoint: request.httpEndpoint)).console()
            return .failure(error)
        }
        
        var urlRequest = request.httpEndpoint.urlRequest(url: url)
        urlRequest.httpMethod = request.httpEndpoint.method.rawValue
        urlRequest.httpBody = request.httpEndpoint.body
        
        guard let result = try? await session.data(for: urlRequest) else {
            let error = HttpError.noConnectivity(statusCode: 0, url: url)
            error.logger(additionalMessage: makeAdditionalMessage(withEndpoint: request.httpEndpoint)).console()
            return .failure(error)
        }
        
        guard let statusCode = (result.1 as? HTTPURLResponse)?.statusCode else {
            let error = HttpError.noConnectivity(statusCode: 0, url: url)
            error.logger(additionalMessage: makeAdditionalMessage(withEndpoint: request.httpEndpoint)).console()
            return .failure(error)
        }
        
        guard let decoded = try? request.decode(result.0, endpoint: request.httpEndpoint) else {
            let error = handleError(url, statusCode: statusCode)
            error.logger(additionalMessage: makeAdditionalMessage(withEndpoint: request.httpEndpoint)).console()
            return .failure(error)
        }
        
        return .success(decoded)
    }
    
    private func makeAdditionalMessage(withEndpoint endpoint: HttpEndpoint?) -> String? {
        if let endpoint = endpoint, let url = endpoint.url {
            var additionalMessage = "\t* Endpoint: [\(endpoint.method.rawValue)] - \(url)"
            
            if let headers = endpoint.headers {
                additionalMessage += "\n\t* Headers: [\(headers.map({ "\($0.rawValue.key): \($0.rawValue.value)" }).joined(separator: ", "))]"
            }
            
            if let body = endpoint.body, let bodyString = String(data: body, encoding: .utf8) {
                additionalMessage += "\n\t* Body: \(bodyString.replacingOccurrences(of: "\\", with: "").replacingOccurrences(of: "\n", with: " "))"
            }
            
            return additionalMessage
        }
        
        return nil
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
