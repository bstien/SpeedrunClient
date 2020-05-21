import Foundation

struct FailableDecodableArray<Element: Decodable>: Decodable {

    var elements: [Element]

    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()

        var elements = [Element]()
        if let count = container.count {
            elements.reserveCapacity(count)
        }

        while !container.isAtEnd {
            if let element = try container.decode(FailableDecodable<Element>.self).element {
                elements.append(element)
            }
        }

        self.elements = elements
    }
}
