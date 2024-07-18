import Foundation
import Combine

protocol CharactersListViewModel {
    var charactersModel: AnyPublisher<CharactersWithSectionModel, Never> { get }
    
    func viewDidLoad()
    func getCharactersModel() async throws
}
