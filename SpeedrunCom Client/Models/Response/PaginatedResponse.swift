import Foundation

struct PaginatedResponse<T: Decodable>: Decodable {
    let data: T
    let pagination: Pagination
}
