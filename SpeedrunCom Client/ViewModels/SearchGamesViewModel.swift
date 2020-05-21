import Foundation
import Combine

class SearchGamesViewModel: ObservableObject {
    @Published var games: [Game] = []
    var cancellationToken: AnyCancellable?

    init() {
        fetchGames()
    }
}

extension SearchGamesViewModel {
    func fetchGames() {
        cancellationToken = SpeedrunApi
            .games()
            .mapError({ (error) -> Error in
                print(error)
                return error
            })
            .sink(
                receiveCompletion: { _ in },
                receiveValue: {
                    self.games = $0.data
                }
            )
    }
}
