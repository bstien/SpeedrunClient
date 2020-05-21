import Foundation

struct Platform: Decodable {
    let id: String
    let name: String
    let released: Int
}

struct PlatformClient {
    static let shared = PlatformClient()
    let platforms: [Platform]

    private init() {
        guard
            let url = Bundle.main.url(forResource: "platforms", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let platforms = try? JSONDecoder().decode([Platform].self, from: data)
        else {
            self.platforms = []
            return
        }

        self.platforms = platforms
    }
}
