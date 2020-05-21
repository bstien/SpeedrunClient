import SwiftUI

struct RemoteImageView<ErrorView: View, ImageView: View, LoadingView: View>: View {
    private let url: URL?
    private let errorView: () -> ErrorView
    private let imageView: (Image) -> ImageView
    private let loadingView: () -> LoadingView
    @ObservedObject private var remoteImageClient = RemoteImageClient()

    var body: AnyView {
        switch remoteImageClient.state {
        case .error:
            return AnyView(errorView())
        case .image(let image):
            return AnyView(imageView(Image(uiImage: image)))
        case .loading:
            return AnyView(
                loadingView().onAppear { self.remoteImageClient.fetchImage(atURL: self.url) }
            )
        }
    }

    init(
        url: URL?,
        @ViewBuilder errorView: @escaping () -> ErrorView,
        @ViewBuilder imageView: @escaping (Image) -> ImageView,
        @ViewBuilder loadingView: @escaping () -> LoadingView
    ) {
        self.url = url
        self.errorView = errorView
        self.imageView = imageView
        self.loadingView = loadingView
    }
}

