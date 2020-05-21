import SwiftUI
import Combine

enum RemoteImageState {
    case error
    case image(_ image: UIImage)
    case loading
}

class RemoteImageClient: ObservableObject {
    var state: RemoteImageState = .loading {
        didSet {
            objectWillChange.send()
        }
    }

    private var cancellable: AnyCancellable?
    private static let cache = NSCache<NSURL, UIImage>()

    func fetchImage(atURL url: URL?) {
        cancellable?.cancel()

        guard let url = url else {
            self.state = .error
            return
        }

        if let image = RemoteImageClient.cache.object(forKey: url as NSURL) {
            state = .image(image)
            return
        }

        cancellable = imageRequest(url: url)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.state = .error
                default:
                    break
                }
            }, receiveValue: { image in
                if let image = image {
                    RemoteImageClient.cache.setObject(image, forKey: url as NSURL)
                    self.state = .image(image)
                } else {
                    self.state = .error
                }
            }
        )
    }

    func imageRequest(url: URL) -> AnyPublisher<UIImage?, URLError> {
        URLSession.shared
            .dataTaskPublisher(for: URLRequest(url: url))
            .map { UIImage(data: $0.data) }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
