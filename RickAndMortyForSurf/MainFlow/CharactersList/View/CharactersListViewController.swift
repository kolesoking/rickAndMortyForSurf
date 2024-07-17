import SnapKit

final class CharactersListViewController: CommonViewController<CharactersListView> {
    private let networkService = NetworkServiceImpl()
    
    override var isNavBarHidden: Bool {
        return true
    }
    
    override init() {
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        networkService.request(with: "") { [weak self] result in
            switch result {
            case .success(let data):
                print(data)
                self?.asdasd(data: data)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func asdasd(data: Data) {
        do {
            let decoder = JSONDecoder()
            let model = try decoder.decode(Model.self, from: data)
            print(model.characters)
        } catch {
            print(error)
        }
    }
}

struct Model: Codable {
    let characters: String
    let locations: String
    let episodes: String
}
