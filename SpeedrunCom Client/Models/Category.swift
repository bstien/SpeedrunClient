import Foundation

struct Category: Decodable {
    enum Kind: String, Decodable {
        case perGame = "per-game"
        case perLevel = "per-level"
    }

    let id: String
    let name: String
    let type: Kind
    let rules: String?
    let links: [Link]
}
