import Foundation
import Combine

struct SpeedrunFilterModel: Equatable {
    var runStatus: RunStatus = .new
    var orderBy: OrderBy.Run = .game
    var sorting: SortDirection = .desc
}

class SpeedrunListViewModel: ObservableObject {
    @Published private(set) var speedruns: [Speedrun] = []
    @Published var filterModel = SpeedrunFilterModel() {
        didSet {
            guard oldValue != filterModel else { return }
            currentOffset = 0
            fetchSpeedruns()
        }
    }

    private var currentOffset = 0
    private var fetchRequestToken: AnyCancellable?

    init() {
        fetchSpeedruns()
    }

    func loadNextPage() {
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
                sorting: filterModel.sorting,
                offset: currentOffset
            )
            .mapError({ (error) -> Error in
                print(error)
                return error
            })
            .sink(
            receiveCompletion: { _ in },
            receiveValue: {
                if $0.pagination.offset == 0 {
                    self.speedruns = $0.data
                } else {
                    self.speedruns.append(contentsOf: $0.data)
                }
                self.currentOffset = $0.pagination.nextOffset
            }
        )
    }
}
