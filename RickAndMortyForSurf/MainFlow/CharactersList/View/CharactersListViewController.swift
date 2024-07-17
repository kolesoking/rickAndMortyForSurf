import SnapKit

final class CharactersListViewController: CommonViewController<CharactersListView> {
    private let networkService = NetworkServiceImpl()
    private let viewModel: CharactersListViewModel
    
    override var isNavBarHidden: Bool {
        return true
    }
    
    init(viewModel: CharactersListViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        viewModel.viewDidLoad()
        configureBindings()
        
//        networkService.request(with: "character") { [weak self] result in
//            switch result {
//            case .success(let data):
//                print(data)
//                self?.asdasd(data: data)
//                
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }
    
//    func asdasd(data: Data) {
//        do {
//            let decoder = JSONDecoder()
//            let model = try decoder.decode(CharactersWithInfoModel.self, from: data)
//            print(model)
////            print(model.name)
//        } catch {
//            print(error)
//        }
//    }
    
    func configureBindings() {
        bind(viewModel.charactersModel) { model in
            print("model: \(model)")
        }
    }
}
