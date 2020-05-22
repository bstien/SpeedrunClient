import Foundation

enum RunStatus: String, Decodable, CaseIterable {
    case new
    case verified
    case rejected
}

extension RunStatus {
    var humanReadable: String {
        rawValue.capitalized
    }
}
