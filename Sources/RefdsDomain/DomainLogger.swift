import Foundation

public protocol DomainLoggerDataSource {
    func logger(additionalMessage: String?) -> DomainLogger
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
    
    public func console(withPresitence persistence: (Bool, UserDefaults?)? = nil) {
        let log = "\n[LOGGER] \(tag.rawValue) at [\(date.asString())]\n\(content)\n"
        if let persistence = persistence, persistence.0, let data = self.asData {
            persistence.1?.set(data, forKey: "\(tag.rawValue) \(date.asString())")
        }
        print(log)
    }
}

public enum DomainLoggerTag: String, DomainModel {
    case info = "[INFO]"
    case error = "[ERROR]"
}
