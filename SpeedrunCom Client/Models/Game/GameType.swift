import Foundation

struct GameType: Codable {
    let id: String
    let name: String
    let allowsBaseGame: Bool
    let links: [Link]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case allowsBaseGame = "allows-base-game"
        case links
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        allowsBaseGame = try container.decode(Bool.self, forKey: .allowsBaseGame)
        links = try container.decode(FailableDecodableArray<Link>.self, forKey: .links).elements
    }
}
