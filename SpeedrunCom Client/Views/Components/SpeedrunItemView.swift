import SwiftUI

struct SpeedrunItemView: View {
    @State var speedrun: Speedrun
    @State var geometryProxy: GeometryProxy

    private var imageSize: CGFloat {
        min(geometryProxy.size.width, geometryProxy.size.height) / 4
    }

    var body: some View {
        HStack(alignment: .top) {
            Group {
                RemoteImageView(
                    url: self.speedrun.game?.assets.coverMedium?.url,
                    errorView: { Rectangle().fill(Color.red) },
                    imageView: { $0.resizable() },
                    loadingView: { Rectangle().fill(Color.gray) }
                ).scaledToFill()
            }
            .frame(width: self.imageSize, height: self.imageSize)
            .cornerRadius(8)

            VStack(alignment: .leading) {
                Text(self.speedrun.game?.name ?? "Unknown game")
                Text(self.speedrun.times.primary)
                Text(self.speedrun.date)
                Text(self.speedrun.status.rawValue)
            }
        }
    }
}
