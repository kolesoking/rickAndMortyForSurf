import SnapKit

final class CharactersListView: CommonView {
    private let label = UILabel()
    private let imageView = UIImageView()
    
    override func setupUI() {
//        setupLabel()
        setupImage()
    }
    
    func updateUI(with url: String) {
        updateImage(with: url)
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
    
    func setupImage() {
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.size.equalTo(100)
        }
    }
    
    func updateImage(with url: String) {
        imageView.loadImage(with: url) { [weak self] image in
            guard let image else {
                print("error: lol")
                return
            }
            self?.imageView.image = image
        }
    }
}
