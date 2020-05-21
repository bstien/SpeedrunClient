import Foundation

struct OrderBy {
    enum Run: String {
        case category
        case date
        case emulated
        case game
        case level
        case platform
        case region
        case status
        case submitted
        case verifyDate = "verify-date"
    }
}
