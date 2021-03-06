import Foundation

public final class SmartCache<Key: Hashable & FilenameConvertible, Value: PersistentCacheValue> {

    private var memoryCache: MemoryCache<Key, Value>
    private var persistentCache: PersistentCache<Key, Value>

    /// Default Initializer
    /// - Parameters:
    ///   - lifetime: Time in seconds. nil - unlimited, default - nil
    ///   - maximumCachedValues: Amount of elements to be stored. 0 == unlimited, default - unlimited
    ///   - cacheDirectory: URL for storing cache files. Default = System cache directory
    public init(lifetime: TimeInterval? = nil, maximumCachedValues: Int = 0, cacheDirectory: URL? = nil) {
        self.memoryCache = .init(lifetime: lifetime, maximumCachedValues: maximumCachedValues)
        self.persistentCache = .init(cacheDirectory: cacheDirectory)
    }

}

extension SmartCache: Cache {

    public func insert(_ value: Value, forKey key: Key) throws {
        memoryCache[key] = value
        persistentCache[key] = value

    }

    public func value(forKey key: Key) throws -> Value? {
        if let memoryEntry = memoryCache[key] {
            return memoryEntry
        } else if let persistentEntry = persistentCache[key] {
            memoryCache[key] = persistentEntry
            return persistentEntry
        } else {
            return nil
        }
    }

    public func removeValue(forKey key: Key) throws {
        memoryCache[key] = nil
        persistentCache[key] = nil
    }

}
