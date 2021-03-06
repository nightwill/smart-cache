import Foundation

public final class PersistentCache<Key: FilenameConvertible, Value: PersistentCacheValue> {

    public let cacheDirectory: URL

    /// Default Initializer
    /// - Parameters:
    ///   - cacheDirectory: Directory for caching. nil - user cache directory, default - nil
    public init(cacheDirectory: URL? = nil) {
        self.cacheDirectory = cacheDirectory ?? FileManager.default.cacheDirectory
    }

}

extension PersistentCache: Cache {

    public func insert(_ value: Value, forKey key: Key) throws {
        let url = fileURL(forKey: key)
        try value.cacheData().write(to: url)
    }

    public func value(forKey key: Key) throws -> Value? {
        let url = fileURL(forKey: key)
        guard FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        let data = try Data(contentsOf: url)
        return try Value.init(cacheData: data)
    }

    public func removeValue(forKey key: Key) throws {
        let url = fileURL(forKey: key)
        try FileManager.default.removeItem(at: url)
    }

    private func fileURL(forKey key: Key) -> URL {
        cacheDirectory.appendingPathComponent(key.filename)
    }

}

private extension FileManager {

    var cacheDirectory: URL {
        urls(for: .cachesDirectory, in: .userDomainMask)[0]
    }

}
