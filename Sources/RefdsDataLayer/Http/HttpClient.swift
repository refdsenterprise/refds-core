import Foundation

public protocol HttpClient {
    func request<Request: HttpRequestProtocol>(_ request: Request) async -> Result<Request.Response, HttpError>
}
