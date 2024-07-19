import SnapKit

final class CharacterView: CommonView {
    private let headerView = HeaderView()
    private let scrollView = UIScrollView()
    private let containerView = UIView()
    
    private let imageView = UIImageView()
    
    private let lifeStatusView = UIView()
    private let lifeStatusLabel = UILabel()
    
    private let speciesLabel = UILabel()
    private let genderLabel = UILabel()
    private let episodesLabel = UILabel()
    private let lastLocationLabel = UILabel()
    
    override func setupUI() {
        backgroundColor = .black
        setupHeadeView()
        setupScrollView()
        setupContainerView()
        setupImageView()
        
        setupLifeStatusView()
        setupLifeStatusLabel()
        
        setupSpeciesLabel()
        setupGenderLabel()
        setupEpisodesLabel()
        setupLastLocationLabel()
    }
    
    func updateUI(with model: CharacterCellModel) {
        headerView.updateUI(with: model.name)
        updateImageView(with: model.image)
        updateLifeStatusView(with: model.status)
        updateSpeciesLabel(with: model.species)
        updateGenderLabel(with: model.gender)
        updateEpisodesLabel(with: model.episodes)
        updateLastLocationLabel(with: model.lastLocation)
    }
}

// MARK: - Setup Actions -
extension CharacterView {
    func setupGoBackAction(_ action: @escaping (() -> Void)) {
        headerView.setupGoBackAction(action)
    }
}

// MARK: - Private Extension -
private extension CharacterView {
    func setupHeadeView() {
        addSubview(headerView)
        headerView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
        }
    }
    
    func setupScrollView() {
        addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(headerView.snp.bottom)
            $0.bottom.equalToSuperview()
        }
    }
    
    func setupContainerView() {
        containerView.backgroundColor = UIColor(
            red: 0x15/255,
            green: 0x15/255,
            blue: 0x17/255,
            alpha: 1
        )
        containerView.layer.cornerRadius = 24
        
        scrollView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20)
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.width.equalTo(353)
        }
    }
    
    func setupImageView() {
        imageView.backgroundColor = .white
        
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        containerView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(imageView.snp.width)
        }
    }
    
    func setupLifeStatusView() {
        lifeStatusView.layer.cornerRadius = 16
        
        containerView.addSubview(lifeStatusView)
        lifeStatusView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.top.equalTo(imageView.snp.bottom).offset(12)
            $0.height.equalTo(42)
        }
    }
    
    func setupLifeStatusLabel() {
        lifeStatusLabel.textColor = .white
        lifeStatusLabel.font = UIFont.boldSystemFont(ofSize: 16)
        lifeStatusLabel.textAlignment = .center
        
        lifeStatusView.addSubview(lifeStatusLabel)
        lifeStatusLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    func setupSpeciesLabel() {
        speciesLabel.textColor = .white
        
        containerView.addSubview(speciesLabel)
        speciesLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16)
            $0.top.equalTo(lifeStatusView.snp.bottom).offset(24)
        }
    }
    
    func setupGenderLabel() {
        genderLabel.textColor = .white
        
        containerView.addSubview(genderLabel)
        genderLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16)
            $0.top.equalTo(speciesLabel.snp.bottom).offset(12)
        }
    }
    
    func setupEpisodesLabel() {
        episodesLabel.textColor = .white
        episodesLabel.numberOfLines = 0
        episodesLabel.lineBreakMode = .byWordWrapping
        
        containerView.addSubview(episodesLabel)
        episodesLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.top.equalTo(genderLabel.snp.bottom).offset(12)
        }
    }
    
    func setupLastLocationLabel() {
        lastLocationLabel.textColor = .white
        lastLocationLabel.numberOfLines = 0
        lastLocationLabel.lineBreakMode = .byWordWrapping
        
        containerView.addSubview(lastLocationLabel)
        lastLocationLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16)
            $0.top.equalTo(episodesLabel.snp.bottom).offset(12)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
    
    func updateImageView(with image: String) {
        imageView.loadImage(with: image) { [weak self] image in
            guard let image else { return }
            self?.imageView.image = image
        }
    }
    
    func updateLifeStatusView(with status: LifeStatus) {
        lifeStatusLabel.text = status.rawValue
        switch status {
        case .alive:
            lifeStatusView.backgroundColor = UIColor(named: "myGreen")
        case .dead:
            lifeStatusView.backgroundColor = UIColor(named: "myRed")
        case .uknown:
            lifeStatusView.backgroundColor = UIColor(named: "myGray")
        }
    }
    
    func updateSpeciesLabel(with text: String) {
        updateLabel(speciesLabel, with: "Species: ", and: text)
    }
    
    func updateGenderLabel(with text: String) {
        updateLabel(genderLabel, with: "Gender: ", and: text)
    }
    
    func updateEpisodesLabel(with episodes: [String]) {
        let text = episodes.joined(separator: ", ")
        updateLabel(episodesLabel, with: "Episodes: ", and: text)
    }
    
    func updateLastLocationLabel(with text: String) {
        updateLabel(lastLocationLabel, with: "Last knows location: ", and: text)
    }
    
    func updateLabel(_ label: UILabel, with boldText: String, and text: String) {
        let attributedString = NSMutableAttributedString()
        
        attributedString.append(
            NSAttributedString(string: boldText, attributes: getBoldAttributes())
        )
        attributedString.append(
            NSAttributedString(string: text, attributes: getTextAttributes())
        )
        
        label.attributedText = attributedString
    }
    
    func getBoldAttributes() -> [NSAttributedString.Key : Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.minimumLineHeight = 16
        paragraphStyle.maximumLineHeight = 16
        let boldAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 16),
            .paragraphStyle: paragraphStyle
        ]
        
        return boldAttributes
    }
    
    func getTextAttributes() -> [NSAttributedString.Key : Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.minimumLineHeight = 16
        paragraphStyle.maximumLineHeight = 16
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16),
            .paragraphStyle: paragraphStyle
        ]
        
        return textAttributes
    }
}
