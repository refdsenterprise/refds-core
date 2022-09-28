import Foundation

public protocol DomainLoggerDataSource {
    var logger: DomainLogger { get }
}

public struct DomainLogger: DomainModel {
    public var tag: DomainLoggerTag
    public var date: Date
    public var content: String
    
    public init(tag: DomainLoggerTag, date: Date, content: String) {
        self.tag = tag
        self.date = date
        self.content = content
    }
    
    public func console() {
        print("\n[LOGGER] \(tag.rawValue) at [\(date.asString())]\n\(content)\n")
    }
}

public enum DomainLoggerTag: String, DomainModel {
    case info = "[INFO]"
    case error = "[ERROR]"
}
