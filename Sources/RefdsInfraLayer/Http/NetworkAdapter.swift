import Foundation
import RefdsDataLayer

public class NetworkAdapter {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    private func handle(_ url: URL, statusCode: Int, withData data: Data) -> Result<Data, HttpError> {
        switch statusCode {
        case 200...299: return .success(data)
        case 401: return .failure(.unauthorized(statusCode: statusCode, url: url))
        case 403: return .failure(.forbidden(statusCode: statusCode, url: url))
        case 400...499: return .failure(.badRequest(statusCode: statusCode, url: url))
        case 500...599: return .failure(.serverError(statusCode: statusCode, url: url))
        default: return .failure(.noConnectivity(statusCode: statusCode, url: url))
        }
    }
}

// MARK: - HttpClient
extension NetworkAdapter: HttpClient {
    public func get(toURL url: URL) async -> HttpGetClient.Result {
        guard let result = try? await session.data(from: url) else { return .failure(.noConnectivity(statusCode: 0, url: url)) }
        guard let statusCode = (result.1 as? HTTPURLResponse)?.statusCode else { return .failure(.noConnectivity(statusCode: 0, url: url)) }
        return handle(url, statusCode: statusCode, withData: result.0)
    }
}
