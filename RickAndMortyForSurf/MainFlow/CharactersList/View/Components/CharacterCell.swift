import SnapKit

final class CharacterCell: UICollectionViewCell {
    private let contaionerView = UIView()
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let lifeStatusLabel = UILabel()
    private let dotSeparator = UIView()
    private let speciesLabel = UILabel()
    private let genderLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        assertionFailure("init(coder:) has not been implemented")
        return nil
    }
    
    func updateUI(with model: CharacterCellModel) {
        updateImageView(with: model.image)
        updateNameLabel(with: model.name)
        updateLifeStatus(with: model.status)
        updateSpeciesLabel(with: model.species)
        updateGenderLabel(with: model.gender)
    }
}

// MARK: - Private Extension -
private extension CharacterCell {
    func setupUI() {
        setupContainerView()
        setupImageView()
        setupNameLabel()
        setupLifeStatusLabel()
        setupDotSeparator()
        setupSpeciesLabel()
        setupGenderLabel()
    }
    
    func setupContainerView() {
        contaionerView.layer.cornerRadius = 24
        contaionerView.backgroundColor = UIColor(
            red: 0x15/255,
            green: 0x15/255,
            blue: 0x17/255,
            alpha: 1
        )
        
        addSubview(contaionerView)
        contaionerView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(96)
        }
    }
    
    func setupImageView() {
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        contaionerView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(15)
            $0.width.equalTo(84)
            $0.height.equalTo(64)
            $0.centerY.equalToSuperview()
        }
    }
    
    func setupNameLabel() {
        nameLabel.text = "TEST NAME"
        nameLabel.textColor = .white
        
        contaionerView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.left.equalTo(imageView.snp.right).offset(16)
            $0.top.equalTo(imageView.snp.top)
        }
    }
    
    func setupLifeStatusLabel() {
        lifeStatusLabel.text = "TEST LIFESTATUS"
        
        contaionerView.addSubview(lifeStatusLabel)
        lifeStatusLabel.snp.makeConstraints {
            $0.left.equalTo(imageView.snp.right).offset(16)
            $0.top.equalTo(nameLabel.snp.bottom).offset(6)
        }
    }
    
    func setupDotSeparator() {
        dotSeparator.layer.cornerRadius = 2
        dotSeparator.backgroundColor = .white
        
        contaionerView.addSubview(dotSeparator)
        dotSeparator.snp.makeConstraints {
            $0.size.equalTo(4)
            $0.centerY.equalTo(lifeStatusLabel.snp.centerY)
            $0.left.equalTo(lifeStatusLabel.snp.right).offset(4)
        }
    }
    
    func setupSpeciesLabel() {
        speciesLabel.text = "TEST GENDER"
        speciesLabel.textColor = .white
        
        contaionerView.addSubview(speciesLabel)
        speciesLabel.snp.makeConstraints {
            $0.left.equalTo(dotSeparator.snp.right).offset(4)
            $0.top.equalTo(nameLabel.snp.bottom).offset(6)
        }
    }
    
    func setupGenderLabel() {
        genderLabel.text = "TEST SPECIES"
        genderLabel.textColor = .white
        
        contaionerView.addSubview(genderLabel)
        genderLabel.snp.makeConstraints {
            $0.left.equalTo(imageView.snp.right).offset(16)
            $0.top.equalTo(lifeStatusLabel.snp.bottom).offset(6)
        }
    }
    
    func updateImageView(with image: String) {
        imageView.loadImage(with: image) { [weak self] image in
            guard let image else { return }
            self?.imageView.image = image
        }
    }
    
    func updateNameLabel(with text: String) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.minimumLineHeight = 18
        paragraphStyle.maximumLineHeight = 18
        let attributes = NSAttributedString(
            string: text,
            attributes: [
                .font: UIFont.systemFont(ofSize: 18, weight: .bold),
                .paragraphStyle: paragraphStyle
            ]
        )
        nameLabel.attributedText = attributes
    }
    
    func updateLifeStatus(with status: LifeStatus) {
        switch status {
        case .alive:
            lifeStatusLabel.textColor = UIColor(named: "myGreen")
        case .dead:
            lifeStatusLabel.textColor = UIColor(named: "myRed")
        case .uknown:
            lifeStatusLabel.textColor = UIColor(named: "myGray")
        }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.minimumLineHeight = 16
        paragraphStyle.maximumLineHeight = 16
        let attributes = NSAttributedString(
            string: status.rawValue,
            attributes: [
                .font: UIFont.systemFont(ofSize: 12, weight: .bold),
                .paragraphStyle: paragraphStyle
            ]
        )
        lifeStatusLabel.attributedText = attributes
    }
    
    func updateSpeciesLabel(with text: String) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.minimumLineHeight = 16
        paragraphStyle.maximumLineHeight = 16
        let attributes = NSAttributedString(
            string: text,
            attributes: [
                .font: UIFont.systemFont(ofSize: 12, weight: .bold),
                .paragraphStyle: paragraphStyle
            ]
        )
        speciesLabel.attributedText = attributes
    }
    
    func updateGenderLabel(with text: String) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.minimumLineHeight = 16
        paragraphStyle.maximumLineHeight = 16
        let attributes = NSAttributedString(
            string: text,
            attributes: [
                .font: UIFont.systemFont(ofSize: 12, weight: .light),
                .paragraphStyle: paragraphStyle
            ]
        )
        genderLabel.attributedText = attributes
    }
}
