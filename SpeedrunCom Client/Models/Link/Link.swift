import Foundation

struct Link: Codable {
    let kind: LinkKind
    let url: URL

    enum CodingKeys: String, CodingKey {
        case kind = "rel"
        case url = "uri"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let kindString = try container.decode(String.self, forKey: .kind)
        if let kind = LinkKind(rawValue: kindString) {
            self.kind = kind
        } else {
            throw DecodingError.valueNotFound(LinkKind.self, DecodingError.Context(codingPath: [], debugDescription: "Could not parse LinkKind of type '\(kindString)'"))
        }
        url = try container.decode(URL.self, forKey: .url)
    }
}
