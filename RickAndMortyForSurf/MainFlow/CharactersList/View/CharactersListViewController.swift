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
    }
    
    func configureBindings() {
        bind(viewModel.charactersModel) { [weak self] model in
            print("model: \(model)")
            self?.contentView.updateUI(with: model[2].image)
        }
    }
}
