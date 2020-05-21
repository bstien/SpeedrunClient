import SwiftUI

struct SearchGamesView: View {
    @ObservedObject var viewModel = SearchGamesViewModel()

    var body: some View {
        List(viewModel.games) { game in
            HStack {
                VStack(alignment: .leading) {
                    Text(game.name)
                        .font(.headline)
                    Text(DateFormatter.yyyyMMdd.string(from: game.releaseDate!))
                        .font(.caption)
                        .italic()
                }
            }
        }
    }
}

extension Game {
    var name: String {
        names.namePrioritized
    }
}

struct SearchGamesView_Previews: PreviewProvider {
    static var previews: some View {
        SearchGamesView()
    }
}
