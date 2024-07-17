import Foundation
import Combine

protocol CharactersListViewModel {
    var charactersModel: AnyPublisher<[CharacterModel], Never> { get }
    
    func viewDidLoad()
    func getCharactersModel() async throws
}
