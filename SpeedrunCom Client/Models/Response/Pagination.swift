import Foundation

struct Pagination: Decodable {
    let offset: Int
    let max: Int
    let size: Int
    let links: [Link]

    var previousLink: Link? {
        links.filter { $0.kind == .prev }.first
    }

    var nextLink: Link? {
        links.filter { $0.kind == .next }.first
    }

    var hasNextPage: Bool {
        nextLink != nil
    }

    var nextOffset: Int {
        offset + size
    }

    enum CodingKeys: String, CodingKey {
        case offset
        case max
        case size
        case links
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        offset = try container.decode(Int.self, forKey: .offset)
        max = try container.decode(Int.self, forKey: .max)
        size = try container.decode(Int.self, forKey: .size)
        links = try container.decode(FailableDecodableArray<Link>.self, forKey: .links).elements
    }
}
