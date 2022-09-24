import Foundation

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
        print("[LOGGER] \(tag.rawValue)\n\t* Date: \(date.asString())\n\t* Content: \(content)")
    }
}

public enum DomainLoggerTag: String, DomainModel {
    case info = "[INFO]"
    case error = "[ERROR]"
}
