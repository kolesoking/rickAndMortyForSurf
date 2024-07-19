import SnapKit

final class CharacterViewController: CommonViewController<CharacterView> {
    private let characterCellModel: CharacterCellModel
    
//    override var isNavBarHidden: Bool {
//        return true
//    }
    
    init(characterCellModel: CharacterCellModel) {
        self.characterCellModel = characterCellModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.updateUI(with: characterCellModel)
        setupActions()
    }
    
    func setupActions() {
        contentView.setupGoBackAction { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}
