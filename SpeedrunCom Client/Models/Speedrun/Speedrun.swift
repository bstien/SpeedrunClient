import Foundation

struct Speedrun: Decodable, Identifiable {
    let id: String
    let status: RunStatus
    let date: String?
    let game: Game
    let times: RunTimes
    let links: [Link]

    enum CodingKeys: String, CodingKey {
        case id
        case status
        case date
        case game
        case times
        case links
    }

    enum StatusCodingKeys: String, CodingKey {
        case status
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        status = (try container.nestedContainer(keyedBy: StatusCodingKeys.self, forKey: .status).decode(RunStatus.self, forKey: .status))
        date = try? container.decode(String.self, forKey: .date)
        game = (try container.nestedContainer(keyedBy: DataCodingKeys.self, forKey: .game).decode(Game.self, forKey: .data))
        times = try container.decode(RunTimes.self, forKey: .times)
        links = try container.decode(FailableDecodableArray<Link>.self, forKey: .links).elements
    }
}
