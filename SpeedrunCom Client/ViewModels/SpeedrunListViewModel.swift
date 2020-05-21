import Foundation
import Combine

class SpeedrunListViewModel: ObservableObject {
    @Published var speedruns: [Speedrun] = []
    var cancellationToken: AnyCancellable?

    init() {
        fetchSpeedruns()
    }
}

extension SpeedrunListViewModel {
    func fetchSpeedruns() {
        cancellationToken = SpeedrunApi
            .speedruns()
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
