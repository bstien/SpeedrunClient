import Foundation

struct GameNames: Decodable {
    let international: String?
    let japanese: String?
    let twitch: String?

    var namePrioritized: String {
        international ?? twitch ?? japanese ?? "No name given"
    }
}
