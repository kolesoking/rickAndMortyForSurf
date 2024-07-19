import SnapKit

final class HeaderView: CommonView {
    private let goBackButton = UIButton()
    private let titleLabel = UILabel()
    
    private var goBackAction: (() -> Void)?
    
    override func setupUI() {
        backgroundColor = .black
        setupGoBackButton()
        setupTitleLabel()
    }
    
    func updateUI(with text: String) {
        updateTitleLabel(with: text)
    }
    
    func isHiddenButton(_ isHidden: Bool) {
        goBackButton.isHidden = isHidden
    }
}

// MARK: - Setup Actions -
extension HeaderView {
    func setupGoBackAction(_ action: @escaping (() -> Void)) {
        self.goBackAction = action
    }
}

// MARK: - Private Extension -
private extension HeaderView {
    func setupGoBackButton() {
        goBackButton.setImage(UIImage(named: "backArrow"), for: .normal)
        goBackButton.addTarget(
            self,
            action: #selector(didTap),
            for: .touchUpInside)
        
        addSubview(goBackButton)
        goBackButton.snp.makeConstraints {
            $0.left.equalToSuperview().inset(20)
            $0.top.bottom.equalToSuperview().inset(16)
            $0.size.equalTo(24)
        }
    }
    
    func setupTitleLabel() {
        titleLabel.textColor = .white
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(goBackButton.snp.right).offset(10)
            $0.centerY.centerX.equalToSuperview()
        }
    }
    
    func updateTitleLabel(with text: String) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.minimumLineHeight = 31.2
        paragraphStyle.maximumLineHeight = 31.2
        let attributes = NSAttributedString(
            string: text,
            attributes: [
                .font: UIFont.boldSystemFont(ofSize: 24),
                .paragraphStyle: paragraphStyle
            ]
        )
        titleLabel.attributedText = attributes
    }
    
    @objc func didTap() {
        goBackAction?()
    }
}
