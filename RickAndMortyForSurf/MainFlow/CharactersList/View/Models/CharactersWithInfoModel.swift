import Foundation

struct CharactersWithInfoModel: Codable {
    let info: Info
    let results: [CharacterModel]
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
