import Foundation

public protocol HttpGetClient {
    typealias Result = Swift.Result<Data, HttpError>
    func get(toURL url: URL) async -> Result
}
