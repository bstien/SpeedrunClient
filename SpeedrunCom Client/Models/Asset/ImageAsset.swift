import Foundation

struct ImageAsset: Decodable {
    let url: URL
    let width: Int?
    let height: Int?

    enum CodingKeys: String, CodingKey {
        case url = "uri"
        case width
        case height
    }
}
