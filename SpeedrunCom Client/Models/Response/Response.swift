import Foundation

struct Response<T: Decodable>: Decodable {
    let data: T
}
