import Foundation

enum Sorting: String, Identifiable, CaseIterable {
    case asc
    case desc

    var id: String { rawValue }
}

extension Sorting {
    var humanReadable: String {
        switch self {
        case .asc: return "Oldest first"
        case .desc: return "Newest first"
        }
    }
}
