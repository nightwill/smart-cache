import Foundation

extension MemoryCache {

    final class Entry {
        let value: Value
        let expirationDate: Date?

        init(value: Value, expirationDate: Date?) {
            self.value = value
            self.expirationDate = expirationDate
        }

        var isExpirationDateValid: Bool {
            if let date = expirationDate {
                return date > Date()
            } else {
                return true
            }
        }
    }

}
