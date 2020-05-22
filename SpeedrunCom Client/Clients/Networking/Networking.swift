import Foundation
import Combine

struct Networking {
    struct Response<T> {
        let value: T
        let response: URLResponse
    }

    func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<Response<T>, Error> {
        URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in
                let value = try JSONDecoder().decode(T.self, from: result.data)
                return Response(value: value, response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func request<T: Decodable>(_ endpoint: Endpoint, baseUrl: URL) -> AnyPublisher<T, Error> {
        guard var components = URLComponents(url: baseUrl.appendingPathComponent(endpoint.path), resolvingAgainstBaseURL: true)
        else { fatalError("Couldn't create URLComponents") }

        components.queryItems = endpoint.queryItems

        let request = URLRequest(url: components.url!)
        print("🔥🔥🔥🔥 request.url = \(request.url!)")
        return run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
