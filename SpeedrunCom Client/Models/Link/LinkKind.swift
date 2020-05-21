import Foundation

enum LinkKind: String, CaseIterable, Codable {
    case selfLink = "self"
    case runs
    case levels
    case categories
    case variables
    case records
    case series
    case derived
    case romhacks
    case leaderboard
    case derivedGames = "derived-games"
    case baseGame = "base-game"
    case game
    case games
    case prev
    case next
}
