import SwiftUI

struct GameItemView: View {
    @State var game: Game
    @State var geometryProxy: GeometryProxy

    private var imageSize: CGFloat {
        min(geometryProxy.size.width, geometryProxy.size.height) / 4
    }

    var body: some View {
        HStack(alignment: .top) {
            Group {
                RemoteImageView(
                    url: self.game.assets.coverMedium?.url,
                    errorView: { Rectangle().fill(Color.red) },
                    imageView: { $0.resizable() },
                    loadingView: { Rectangle().fill(Color.gray) }
                ).scaledToFill()
            }
            .frame(width: self.imageSize, height: self.imageSize)
            .cornerRadius(8)

            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Text(self.game.names.namePrioritized)
                    Spacer()
                    Text(DateFormatter.yyyyMMdd.string(from: self.game.releaseDate!)).font(.caption).italic()
                }
                Spacer()
                HStack(alignment: .top) {
                    Text("Platforms: ").fontWeight(.bold) + Text(game.platforms.map { $0.name }.joined(separator: ", "))
                }
            }
        }
    }
}
