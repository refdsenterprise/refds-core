import Foundation

public enum HttpHeader {
    case accept(type: HttpHeaderAcceptType)
    case authorization(token: String)
    case contentType(type: HttpHeaderContentType)
    case custom(key: String, value: String)

    public var rawValue: (key: String, value: String) {
        switch self {
        case let .accept(acceptType): return ("Accept", acceptType.rawValue)
        case let .authorization(token): return ("Authorization", token)
        case let .contentType(contentType): return ("Content-Type", contentType.rawValue)
        case let .custom(key, value): return (key, value)
        }
    }
}

public enum HttpHeaderAcceptType: String {
    case applicationJson = "application/json"
}

public enum HttpHeaderContentType: String {
    case applicationJson = "application/json"
}

public extension Array where Element == HttpHeader {
    var asDictionary: [String: String] {
        var dictionary = [String: String]()
        self.forEach({ dictionary[$0.rawValue.key] = $0.rawValue.value })
        return dictionary
    }
}
