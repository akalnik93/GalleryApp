import Foundation

struct APIResponse: Decodable {
    let results: [Result]
}

struct Result: Decodable {
    let id: String
    let created_at: String
    let urls: URLS
    let user: User
    let likes: Int
}

struct URLS: Decodable {
    let regular: String
}

struct User: Decodable {
    let first_name: String?
    let location: String?
}
