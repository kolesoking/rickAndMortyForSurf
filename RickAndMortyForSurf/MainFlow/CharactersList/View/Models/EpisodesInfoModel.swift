import Foundation

struct EpisodesInfoModel: Codable {
    let info: Info
    let results: [EpisodesModel]
}

struct EpisodesModel: Codable {
    let id: Int
    let name: String
    let url: String
}
