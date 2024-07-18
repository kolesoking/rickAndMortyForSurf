import SnapKit

final class CharacterView: CommonView {
    private let titleLabel = UILabel()
    
    override func setupUI() {
        backgroundColor = .red
        setupTitleLabel()
    }
}

// MARK: - Private Extension -
private extension CharacterView {
    func setupTitleLabel() {
        titleLabel.text = "TESTSTSTSATSA"
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
