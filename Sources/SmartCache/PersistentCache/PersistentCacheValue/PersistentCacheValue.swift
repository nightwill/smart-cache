import Foundation

public protocol PersistentCacheValue {

    init(cacheData: Data) throws
    func cacheData() throws -> Data

}

extension PersistentCacheValue where Self: Codable {

    public init(cacheData: Data) throws {
        self = try JSONDecoder().decode(Self.self, from: cacheData)
    }

    public func cacheData() throws -> Data {
        try JSONEncoder().encode(self)
    }

}
