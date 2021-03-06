import Foundation

extension URL: FilenameConvertible {

    public var filename: String {
        let set = CharacterSet(charactersIn: "+=/:?.")
        return path.components(separatedBy: set).joined()
    }

}
