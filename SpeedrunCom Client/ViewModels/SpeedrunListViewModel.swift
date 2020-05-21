import Foundation
import Combine

struct SpeedrunFilterModel {
    var runStatus: RunStatus = .new
    var orderBy: OrderBy.Run = .game
    var sorting: SortDirection = .desc
}

class SpeedrunListViewModel: ObservableObject {
    @Published private(set) var speedruns: [Speedrun] = []
    @Published var filterModel = SpeedrunFilterModel() {
        didSet { fetchSpeedruns()}
    }

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
                status: filterModel.runStatus,
                orderBy: filterModel.orderBy,
                sorting: filterModel.sorting
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
