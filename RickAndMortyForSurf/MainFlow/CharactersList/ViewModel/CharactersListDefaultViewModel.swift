import Foundation
import Combine

final class CharactersListDefaultViewModel {
    private let networkService: NetworkService
    
    private var charactersModelSubject = PassthroughSubject<CharactersWithSectionModel, Never>()
    private var characterModelSubject = PassthroughSubject<CharacterCellModel, Never>()
    
    private let endPoint = "character/"
    private var nextPage = ""
    
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
    
    private var charactersWithSectionModel = CharactersWithSectionModel(
        section: .mane,
        characters: [
            CharacterCellModel(
                image: "",
                name: "",
                status: .uknown,
                species: "",
                gender: "",
                episodes: [""],
                lastLocation: ""
            )
        ]
    )
    
    private var episodesModel = [
        EpisodesModel(
            id: 0,
            name: "",
            url: ""
        )
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
    
    var characterModel: AnyPublisher<CharacterCellModel, Never> {
        characterModelSubject.eraseToAnyPublisher()
    }
    
    func viewDidLoad() {
        requestEpisodes()
        requestCharacters()
    }
    
    func getCharactersModel() async throws {
        
    }
    
    func getCharacterModel(with index: Int) {
        let characterCellModel = getCharacterModel(for: index)
        characterModelSubject.send(characterCellModel)
    }
    
    func getNextPageCharactersModel() {
        requestNextPageCharacters()
        print(episodesModel)
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
    
    func requestEpisodes() {
        networkService.request(with: "episode/") { [weak self] result in
            switch result {
            case .success(let data):
                self?.getAllEpisodes(with: data)
            case .failure(let error):
                print("error: \(error.localizedDescription)")
            }
        }
    }
    
    func requestNextPageCharacters() {
        if !nextPage.isEmpty {
            let newEndPint = "\(endPoint)/?\(createQuery(with: nextPage))"
            networkService.request(with: newEndPint) { [weak self] result in
                switch result {
                case .success(let data):
                    self?.decodeCharacters(with: data)
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                }
            }
        } else {
            print("no nextPage")
        }
    }
    
    func decodeCharacters(with data: Data) {
        do {
            let charactersWithInfoModel = try networkService.decodeJSONData(data: data) as CharactersWithInfoModel
            nextPage = charactersWithInfoModel.info.next ?? ""
            charactersListModel = charactersWithInfoModel.results
            createCharactersWithSectionModel(with: charactersListModel)
        } catch {
            print("error: \(error.localizedDescription)")
        }
    }
    
    func getAllEpisodes(with data: Data) {
        do {
            let episodeInfoModel = try networkService.decodeJSONData(data: data) as EpisodesInfoModel
            for index in 1...episodeInfoModel.info.pages {
                networkService.request(with: "episode/?page=\(String(index))") { [weak self] result in
                    switch result {
                    case .success(let data):
                        self?.decodeEpisode(with: data)
                    case .failure(let error):
                        print("error: \(error.localizedDescription)")
                    }
                }
            }
        } catch {
            print("error: \(error.localizedDescription)")
        }
    }
    
    func decodeEpisode(with data: Data) {
        do {
            let episodesInfoModel = try networkService.decodeJSONData(data: data) as EpisodesInfoModel
            episodesInfoModel.results.forEach { [weak self] in
                self?.episodesModel.append($0)
            }
        } catch {
            print("error: \(error.localizedDescription)")
        }
    }
    
    func getCharacterModel(for index: Int) -> CharacterCellModel {
        var characterModel = charactersWithSectionModel.characters[index]
        characterModel.episodes = filtredEpisodes(with: characterModel.episodes)
        return characterModel
    }
    
    func filtredEpisodes(with episodesURL: [String]) -> [String] {
        let episodes = episodesModel.filter { episodesURL.contains($0.url) }
        return episodes.map { $0.name }
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
        charactersWithSectionModel = CharactersWithSectionModel(
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
    
    func createQuery(with url: String) -> String {
        guard let url = URL(string: url) else { return "" }
        guard let queryString = url.query else { return "" }
        print(queryString)
        return queryString
    }
}
