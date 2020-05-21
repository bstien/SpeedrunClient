import Foundation

struct Genre: Codable {
    let id: String
    let name: String
    let links: [Link]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case links
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        links = try container.decode(FailableDecodableArray<Link>.self, forKey: .links).elements
    }
}
