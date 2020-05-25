import Foundation

struct RunVideos: Decodable {
    let text: String?
    let videoUrls: [URL]

    enum CodingKeys: String, CodingKey {
        case text
        case links
    }

    enum VideoLinkCodingKeys: String, CodingKey {
        case uri
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        text = try? container.decode(String.self, forKey: .text)
        let videoLinks = (try? container.decodeIfPresent([VideoLink].self, forKey: .links)) ?? []
        videoUrls = videoLinks.map { $0.uri }
    }
}

private struct VideoLink: Decodable {
    let uri: URL
}
