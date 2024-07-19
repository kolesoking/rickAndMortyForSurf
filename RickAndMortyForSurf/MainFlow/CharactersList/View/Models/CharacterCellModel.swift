import Foundation

struct CharactersWithSectionModel {
    let section: CharactersListAdapter.Section
    let characters: [CharacterCellModel]
}

struct CharacterCellModel: Hashable {
    let image: String
    let name: String
    let status: LifeStatus
    let species: String
    let gender: String
    var episodes: [String]
    let lastLocation: String
}

enum LifeStatus: String {
    case alive = "Alive"
    case dead = "Dead"
    case uknown = "Uknown"
}
