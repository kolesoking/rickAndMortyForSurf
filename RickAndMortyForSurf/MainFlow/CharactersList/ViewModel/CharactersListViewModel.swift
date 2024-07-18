import Foundation
import Combine

protocol CharactersListViewModel {
    var charactersModel: AnyPublisher<CharactersWithSectionModel, Never> { get }
    var characterModel: AnyPublisher<CharacterCellModel, Never> { get }
    
    func viewDidLoad()
    func getCharactersModel() async throws
    func getCharacterModel(with index: Int)
}
