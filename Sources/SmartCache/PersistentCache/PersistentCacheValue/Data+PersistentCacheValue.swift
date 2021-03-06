import Foundation

extension Data: PersistentCacheValue {

    public init(cacheData: Data) {
        self = cacheData
    }

    public func cacheData() -> Data {
        self
    }

}
