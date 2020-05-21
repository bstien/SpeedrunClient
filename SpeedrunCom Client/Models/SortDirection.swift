import Foundation

enum SortDirection: String, Identifiable, CaseIterable {
    case asc
    case desc

    var id: String { rawValue }
}

extension SortDirection {
    var humanReadable: String {
        switch self {
        case .asc: return "Oldest first"
        case .desc: return "Newest first"
        }
    }
}
