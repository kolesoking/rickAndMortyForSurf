import SnapKit

final class SearchView: CommonView {
    private let containerSearchView = UIView()
    private let searchImageView = UIImageView()
    private let searchTextField = UITextField()
    
    private let filtersButton = UIButton()
    
    private var searchAction: ((String) -> Void)?
    
    override func setupUI() {
        setupFiltersButton()
        setupContainerSearchView()
        setupSearchImageView()
        setupSearchTextField()
    }
}

// MARK: - Setup Actions -
extension SearchView {
    func setupSearchAction(_ action: @escaping ((String) -> Void)) {
        self.searchAction = action
    }
}

// MARK: - Private Extension -
private extension SearchView {
    func setupContainerSearchView() {
        containerSearchView.layer.cornerRadius = 16
        containerSearchView.layer.borderWidth = 2
        containerSearchView.layer.borderColor = UIColor(named: "borderColor")?.cgColor
        
        addSubview(containerSearchView)
        containerSearchView.snp.makeConstraints {
            $0.right.equalTo(filtersButton.snp.left).offset(-16)
            $0.left.top.bottom.equalToSuperview()
        }
    }
    
    func setupSearchImageView() {
        searchImageView.image = UIImage(named: "searchImage")
        
        containerSearchView.addSubview(searchImageView)
        searchImageView.snp.makeConstraints {
            $0.left.equalToSuperview().inset(13)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(16)
        }
    }
    
    func setupSearchTextField() {
        searchTextField.delegate = self
        searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search",
            attributes: [
                .foregroundColor: UIColor.white,
                .font: UIFont.systemFont(ofSize: 14)
            ]
        )
        searchTextField.textColor = .white
        
        containerSearchView.addSubview(searchTextField)
        searchTextField.snp.makeConstraints {
            $0.left.equalTo(searchImageView.snp.right).offset(8)
            $0.top.bottom.equalToSuperview()
            $0.right.equalToSuperview().inset(8)
        }
    }
    
    func setupFiltersButton() {
        filtersButton.setImage(UIImage(named: "filtersIcon"), for: .normal)
        filtersButton.addTarget(
            self,
            action: #selector(tupFiltersButton),
            for: .touchUpInside
        )
        
        addSubview(filtersButton)
        filtersButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview()
            $0.size.equalTo(16)
        }
    }
    
    @objc func tupFiltersButton() {
        print(#function)
    }
}

// MARK: - UITextFieldDelegate -
extension SearchView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else { return false}
        searchAction?(newText)
        return true
    }
}

