import SnapKit

final class CharactersListView: CommonView {
    private let label = UILabel()
    
    override func setupUI() {
        setupLabel()
    }
}

// MARK: - Private extension -
private extension CharactersListView {
    func setupLabel() {
        label.text = "Hello World"
        
        addSubview(label)
        label.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
