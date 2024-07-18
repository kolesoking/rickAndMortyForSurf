import Foundation
import Combine

final class CharactersListDefaultViewModel {
    private let networkService: NetworkService
    
    private var charactersModelSubject = PassthroughSubject<CharactersWithSectionModel, Never>()
    
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
    var charactersModel: AnyPublisher<CharactersWithSectionModel, Never> {
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
            createCharactersWithSectionModel(with: charactersListModel)
        } catch {
            print("error: \(error.localizedDescription)")
        }
    }
    
    func createCharactersWithSectionModel(with model: [CharacterModel]) {
        let charactersCellModel = model.compactMap { charactersModel in
            CharacterCellModel(
                image: charactersModel.image,
                name: charactersModel.name,
                status: setStatus(with: charactersModel.status),
                species: charactersModel.species,
                gender: charactersModel.gender,
                episodes: charactersModel.episode,
                lastLocation: charactersModel.location.name
            )
        }
        let charactersWithSectionModel = CharactersWithSectionModel(
            section: .mane,
            characters: charactersCellModel
        )
        
        charactersModelSubject.send(charactersWithSectionModel)
    }
    
    func setStatus(with text: String) -> LifeStatus {
        if text == "Alive" {
            return .alive
        } else if text == "Dead" {
            return .dead
        } else {
            return .uknown
        }
    }
}
