import Foundation
import RefdsDomain

public protocol HttpRequest {
    associatedtype Response
    
    var httpClient: HttpClient { get set }
    var httpEndpoint: HttpEndpoint { get set }
    
    func decode(_ data: Data, endpoint: HttpEndpoint?) throws -> Response
}

public extension HttpRequest where Response: DomainModel {
    func decode(_ data: Data, endpoint: HttpEndpoint?) throws -> Response {
        guard let decoded: Response = data.asModel() else { throw HttpError.invalidResponse(content: data) }
        decoded.logger(additionalMessage: makeAdditionalMessage(withEndpoint: endpoint)).console()
        return decoded
    }
    
    private func makeAdditionalMessage(withEndpoint endpoint: HttpEndpoint?) -> String? {
        if let endpoint = endpoint, let url = endpoint.url {
            var additionalMessage = "\t* Endpoint: [\(endpoint.method.rawValue)] - \(url)"
            
            if let headers = endpoint.headers {
                additionalMessage += "\n\t* Headers: [\n\t\t\(headers.map({ "\($0.rawValue.key): \($0.rawValue.value)" }).joined(separator: ",\n\t\t"))]"
            }
            
            if let body = endpoint.body, let bodyString = String(data: body, encoding: .utf8) {
                additionalMessage += "\n\t* Body: \(bodyString.replacingOccurrences(of: "\n", with: "\n\t\t"))"
            }
            
            additionalMessage += "\n\t* Response Type: \(Response.self)"
            
            return additionalMessage
        }
        
        return nil
    }
}
