import SnapKit

final class CharactersListView: CommonView {
    
    private let collectionFlowLayout = UICollectionViewFlowLayout()
    private let dataSourse: CharactersListAdapter
    private let collectionView: UICollectionView
    
    private var action: ((Int) -> Void)?
    
    override init(frame: CGRect) {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionFlowLayout)
        dataSourse = CharactersListAdapter(collectionView: collectionView)
        super.init(frame: frame)
        setupUI()
    }
    
    override func setupUI() {
        setupCollectionView()
    }
    
    func updateUI(with model: CharactersWithSectionModel ) {
        dataSourse.update(with: model)
    }
}

// MARK: - Setup Actions -
extension CharactersListView {
    func setupAction(_ action: @escaping ((Int) -> Void)) {
        self.action = action
    }
}

// MARK: - Private extension -
private extension CharactersListView {
    func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: "\(CharacterCell.self)")
        collectionFlowLayout.minimumLineSpacing = 4
        collectionFlowLayout.scrollDirection = .vertical
        
        let screenWidth = UIScreen.main.bounds.width
        collectionFlowLayout.itemSize = CGSize(width: screenWidth - 40, height: 96)
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
    }
}

extension CharactersListView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        action?(indexPath.row)
    }
}
