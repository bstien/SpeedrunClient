import Foundation

struct FailableDecodable<Element: Decodable>: Decodable {

    let element: Element?

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.element = try? container.decode(Element.self)
    }
}
