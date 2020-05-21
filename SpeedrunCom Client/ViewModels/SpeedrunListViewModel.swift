import Foundation
import Combine

class SpeedrunListViewModel: ObservableObject {
    @Published private(set) var speedruns: [Speedrun] = []
    @Published var runStatus: RunStatus = .new { didSet { fetchSpeedruns() }}
    @Published var orderBy: OrderBy.Run = .game { didSet { fetchSpeedruns() }}
    @Published var sorting: SortDirection = .desc { didSet { fetchSpeedruns() }}

    private var fetchRequestToken: AnyCancellable?

    init() {
        fetchSpeedruns()
    }
}

extension SpeedrunListViewModel {
    func fetchSpeedruns() {
        fetchRequestToken?.cancel()
        fetchRequestToken = SpeedrunApi
            .speedruns(
                status: runStatus,
                orderBy: orderBy,
                sorting: sorting
            )
            .mapError({ (error) -> Error in
                print(error)
                return error
            })
            .sink(
            receiveCompletion: { _ in },
            receiveValue: {
                self.speedruns = $0.data
            }
        )
    }
}
