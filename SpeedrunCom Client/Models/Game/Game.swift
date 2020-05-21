import Foundation

struct Game: Decodable, Identifiable {
    let id: String
    let names: GameNames
    let abbreviation: String
    let released: Int
    let releaseDate: Date?
    let categories: [Category]
    let assets: GameAssets
    let links: [Link]

    enum CodingKeys: String, CodingKey {
        case id
        case names
        case abbreviation
        case released
        case releaseDate = "release-date"
        case platforms
        case regions
        case assets
        case links
        case categories
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        names = try container.decode(GameNames.self, forKey: .names)
        abbreviation = try container.decode(String.self, forKey: .abbreviation)
        released = try container.decode(Int.self, forKey: .released)
        categories = (try? container.nestedContainer(keyedBy: DataCodingKeys.self, forKey: .categories).decode([Category].self, forKey: .data)) ?? []
        assets = try container.decode(GameAssets.self, forKey: .assets)
        links = try container.decode(FailableDecodableArray<Link>.self, forKey: .links).elements

        let dateString = try container.decode(String.self, forKey: .releaseDate)
        let formatter = DateFormatter.yyyyMMdd
        if let date = formatter.date(from: dateString) {
            releaseDate = date
        } else {
            releaseDate = nil
        }
    }
}

extension Game: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Game, rhs: Game) -> Bool {
        lhs.id == rhs.id
    }
}
