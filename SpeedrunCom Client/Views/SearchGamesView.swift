import SwiftUI

struct SearchGamesView: View {
    @ObservedObject var viewModel = SearchGamesViewModel()

    var body: some View {
        GeometryReader { geometryProxy in
            List(self.viewModel.games) { game in
                GameItemView(game: game, geometryProxy: geometryProxy)
            }
        }
    }
}

extension Game {
    var name: String {
        names.namePrioritized
    }
}
