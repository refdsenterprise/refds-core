import Foundation

public protocol HttpClient {
    func request<Request: HttpRequest>(_ request: Request) async -> Result<Request.Response, HttpError>
}
