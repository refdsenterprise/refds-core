import Foundation

public class HttpNetworkAdapter: HttpClient {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func request<Request>(_ request: Request, completion: @escaping (Result<Request.Response, HttpError>) -> Void) where Request : HttpRequest {
        guard let url = request.httpEndpoint.url else {
            let error = HttpError.invalidUrl
            error.logger(additionalMessage: makeAdditionalMessage(withEndpoint: request.httpEndpoint)).console()
            return completion(.failure(error))
        }
        
        var urlRequest = request.httpEndpoint.urlRequest(url: url)
        urlRequest.httpMethod = request.httpEndpoint.method.rawValue
        urlRequest.httpBody = request.httpEndpoint.body
        
        session.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, let response = response, error != nil else {
                let error = HttpError.noConnectivity(statusCode: 0, url: url)
                error.logger(additionalMessage: self.makeAdditionalMessage(withEndpoint: request.httpEndpoint)).console()
                return completion(.failure(error))
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                let error = HttpError.noConnectivity(statusCode: 0, url: url)
                error.logger(additionalMessage: self.makeAdditionalMessage(withEndpoint: request.httpEndpoint)).console()
                return completion(.failure(error))
            }
            
            guard let decoded = try? request.decode(data, endpoint: request.httpEndpoint) else {
                let error = self.handleError(url, statusCode: statusCode)
                error.logger(additionalMessage: self.makeAdditionalMessage(withEndpoint: request.httpEndpoint)).console()
                return completion(.failure(error))
            }
            
            completion(.success(decoded))
        }
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
