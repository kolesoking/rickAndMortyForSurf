import SnapKit

final class CharactersListView: CommonView {
    private let headerView = HeaderView()
    
    private let collectionFlowLayout = UICollectionViewFlowLayout()
    private let dataSourse: CharactersListAdapter
    private let collectionView: UICollectionView
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    private var action: ((Int) -> Void)?
    private var updateCollectionAction: (() -> Void)?
    
    private var itemsCount = 0
    private var hasTriggeredUpdateAction = false
    
    override init(frame: CGRect) {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionFlowLayout)
        dataSourse = CharactersListAdapter(collectionView: collectionView)
        super.init(frame: frame)
        setupUI()
    }
    
    override func setupUI() {
        setupHeaderView()
        setupCollectionView()
        setupActivityIndicator()
    }
    
    func updateUI(with model: CharactersWithSectionModel) {
        dataSourse.update(with: model)
        itemsCount = model.characters.count
        
        hasTriggeredUpdateAction = false
    }
}

// MARK: - Setup Actions -
extension CharactersListView {
    func setupAction(_ action: @escaping ((Int) -> Void)) {
        self.action = action
    }
    
    func setupUpdateCollectionAction(_ action: @escaping (() -> Void)) {
        self.updateCollectionAction = action
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
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func setupActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
        
        addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(8)
            $0.size.equalTo(30)
        }
    }
    
    func updateCollectionViewContraintsForActivityIndicator() {
        collectionView.snp.remakeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(headerView.snp.bottom).offset(8)
            $0.bottom.equalTo(activityIndicator.snp.top).offset(-20)
        }
    }
    
    func updateCollectionViewConstreinstForSafeArea() {
        collectionView.snp.remakeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(headerView.snp.bottom).offset(8)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension CharactersListView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        action?(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == itemsCount - 1 && !hasTriggeredUpdateAction {
            hasTriggeredUpdateAction = true
            activityIndicator.startAnimating()
            UIView.animate(withDuration: 0.5) { [weak self] in
                self?.updateCollectionViewContraintsForActivityIndicator()
                self?.layoutIfNeeded()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                self?.updateCollectionViewConstreinstForSafeArea()
                self?.activityIndicator.stopAnimating()
                self?.updateCollectionAction?()
                self?.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
        }
    }
}
