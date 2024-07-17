import SnapKit

final class CharactersListViewController: CommonViewController<CharactersListView> {
    override var isNavBarHidden: Bool {
        return true
    }
    
    override init() {
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}
