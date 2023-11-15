import Foundation

public protocol HttpClient {
    func request<Request: HttpRequest>(_ request: Request, completion: @escaping (Result<Request.Response, HttpError>) -> Void)
}
