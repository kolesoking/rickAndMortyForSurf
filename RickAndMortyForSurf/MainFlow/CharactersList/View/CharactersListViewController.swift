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
        view.backgroundColor = .black
        viewModel.viewDidLoad()
        configureBindings()
    }
    
    func configureBindings() {
        bind(viewModel.charactersModel) { [weak self] model in
            self?.contentView.updateUI(with: model)
        }
    }
}
