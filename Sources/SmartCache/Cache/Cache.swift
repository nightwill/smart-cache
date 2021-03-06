import Foundation

public protocol Cache {
    
    associatedtype Key
    associatedtype Value

    func insert(_ value: Value, forKey key: Key) throws
    func value(forKey key: Key) throws -> Value?
    func removeValue(forKey key: Key) throws

}

extension Cache where Self: AnyObject {

    public subscript(key: Key) -> Value? {
        get { return try? value(forKey: key) }
        set {
            guard let value = newValue else {
                try? removeValue(forKey: key)
                return
            }

            try? insert(value, forKey: key)
        }
    }
    
}
