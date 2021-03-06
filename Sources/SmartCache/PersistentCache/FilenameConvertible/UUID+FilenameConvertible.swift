import Foundation

extension UUID: FilenameConvertible {

    public var filename: String { uuidString }

}
