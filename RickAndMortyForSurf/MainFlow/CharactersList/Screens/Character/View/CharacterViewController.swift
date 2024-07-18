import SnapKit

final class CharacterViewController: CommonViewController<CharacterView> {
    private let characterCellModel: CharacterCellModel
    
    override var isNavBarHidden: Bool {
        return false
    }
    
    init(characterCellModel: CharacterCellModel) {
        self.characterCellModel = characterCellModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        print(characterCellModel)
    }
}
