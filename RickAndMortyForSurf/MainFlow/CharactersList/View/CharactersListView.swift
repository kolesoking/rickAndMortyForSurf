import SnapKit

final class CharactersListView: CommonView {
    private let headerView = HeaderView()
    
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
        setupHeaderView()
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
    func setupHeaderView() {
        headerView.updateUI(with: "Rick & Morty Characters")
        headerView.isHiddenButton(true)
        
        addSubview(headerView)
        headerView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
        }
    }
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
            $0.top.equalTo(headerView.snp.bottom).offset(8)
            $0.bottom.equalToSuperview()
        }
    }
}

extension CharactersListView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        action?(indexPath.row)
    }
}
