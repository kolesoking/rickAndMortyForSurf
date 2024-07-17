import Foundation
import Combine

final class CharactersListDefaultViewModel {
    private let networkService: NetworkService
    
    private var charactersModelSubject = PassthroughSubject<[CharacterModel], Never>()
    
    private let endPoint = "character/"
    
    private var charactersListModel = [
        CharacterModel(
            id: 0,
            name: "",
            status: "",
            species: "",
            type: "",
            gender: "",
            origin: Origin(
                name: "",
                url: ""
            ),
            location: Location(
                name: "",
                url: ""
            ),
            image: "",
            episode: [""],
            url: "",
            created: "")
    ]
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
}

// MARK: - CharactersListViewModel-
extension CharactersListDefaultViewModel: CharactersListViewModel {
    var charactersModel: AnyPublisher<[CharacterModel], Never> {
        charactersModelSubject.eraseToAnyPublisher()
    }
    
    func viewDidLoad() {
        requestCharacters()
    }
    
    func getCharactersModel() async throws {
        
    }
}

// MARK: - Private Extension -
private extension CharactersListDefaultViewModel {
    func requestCharacters() {
        networkService.request(with: endPoint) { [weak self] result in
            switch result {
            case .success(let data):
                self?.decodeCharacters(with: data)
            case .failure(let error):
                print("error: \(error.localizedDescription)")
            }
        }
    }
    
    func decodeCharacters(with data: Data) {
        do {
            let charactersWithInfoModel = try networkService.decodeJSONData(data: data) as CharactersWithInfoModel
            charactersListModel = charactersWithInfoModel.results
            charactersModelSubject.send(charactersListModel)
        } catch {
            print("error: \(error.localizedDescription)")
        }
    }
}
