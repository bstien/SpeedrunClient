import Foundation

struct OrderBy {
    enum Run: String, CaseIterable {
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

extension OrderBy.Run {
    var humanReadable: String {
        switch self {
        case .verifyDate:
            return "Date verified"
        default:
            return rawValue.capitalized
        }
    }
}
