import Foundation

public final class MemoryCache<Key: Hashable, Value> {
    
    private let cache = NSCache<WrappedKey, Entry>()

    public let lifetime: TimeInterval?

    /// Default Initializer
    /// - Parameters:
    ///   - lifetime: Time in seconds. nil - unlimited, default - unlimited
    ///   - maximumCachedValues: Amount of elements to be stored. 0 == unlimited, default - unlimited
    public init(lifetime: TimeInterval? = nil, maximumCachedValues: Int = 0) {
        self.lifetime = lifetime
        cache.countLimit = maximumCachedValues
    }

}

extension MemoryCache: Cache {

    func insert(_ value: Value, forKey key: Key) {
        let date = makeExpirationDate()
        let entry = Entry(value: value, expirationDate: date)
        cache.setObject(entry, forKey: WrappedKey(key))
    }

    func value(forKey key: Key) -> Value? {
        guard let entry = cache.object(forKey: WrappedKey(key)) else {
            return nil
        }

        guard entry.isExpirationDateValid else {
            removeValue(forKey: key)
            return nil
        }

        return entry.value
    }

    func removeValue(forKey key: Key) {
        cache.removeObject(forKey: WrappedKey(key))
    }

    private func makeExpirationDate() -> Date? {
        if let lifetime = lifetime {
            return Date().addingTimeInterval(lifetime)
        } else {
            return nil
        }
    }

}
