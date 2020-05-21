import Foundation
import Combine

enum SpeedrunApi {
    private static let networking = Networking()
    private static let baseUrl = URL(string: "https://www.speedrun.com/api/v1")!

    static func games(withName query: String? = nil, sorting: Sorting, offset: Int) -> AnyPublisher<PaginatedResponse<[Game]>, Error> {
        var queryItems = [
            URLQueryItem(name: "offset", value: "\(offset)"),
            URLQueryItem(name: "orderby", value: "released"),
            URLQueryItem(name: "direction", value: sorting.rawValue)
        ]

        if let query = query {
            queryItems.append(URLQueryItem(name: "name", value: query))
        }

        let endpoint = Endpoint(path: "/games", queryItems: queryItems)
        return networking.request(endpoint, baseUrl: baseUrl)
    }
}
