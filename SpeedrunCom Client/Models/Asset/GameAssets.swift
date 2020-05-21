import Foundation

struct GameAssets: Decodable {
    let logo: ImageAsset?
    let icon: ImageAsset?
    let background: ImageAsset?
    let foreground: ImageAsset?
    let coverTiny: ImageAsset?
    let coverSmall: ImageAsset?
    let coverMedium: ImageAsset?
    let coverLarge: ImageAsset?
    let trophyFirst: ImageAsset?
    let trophySecond: ImageAsset?
    let trophyThird: ImageAsset?
    let trophyFourth: ImageAsset?

    enum CodingKeys: String, CodingKey {
        case logo
        case icon
        case background
        case foreground
        case coverTiny = "cover-tiny"
        case coverSmall = "cover-small"
        case coverMedium = "cover-medium"
        case coverLarge = "cover-large"
        case trophyFirst = "trophy-1st"
        case trophySecond = "trophy-2nd"
        case trophyThird = "trophy-3rd"
        case trophyFourth = "trophy-4th"
    }
}
