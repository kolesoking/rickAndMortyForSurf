import UIKit
import SnapKit
import Combine

open class CommonViewController<View: CommonView>: UIViewController {
    public let contentView: View
    public var cancellableSet = Set<AnyCancellable>()
    
    open var isNavBarHidden: Bool { false }
    
    public init() {
        contentView = View()
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        assertionFailure("init(coder:) has not been implemented")
        return nil
    }
    
    open override func loadView() {
        view = contentView
        contentView.backgroundColor = .black
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar(animated: animated)
    }
    
    public final func bind<T>(_ publisher: AnyPublisher<T, Never>, sink: @escaping (T) -> Void) {
        publisher.receive(on: DispatchQueue.main)
            .sink(receiveValue: sink)
            .store(in: &cancellableSet)
    }
    
    public func freeCancellable() {
        cancellableSet.forEach { $0.cancel() }
    }
    
    public final func setNavigationBarHidden(_ isHidden: Bool, animated: Bool) {
        navigationController?.setNavigationBarHidden(isHidden, animated: animated)
    }
    
    private func setupNavBar(animated: Bool) {
        setNavigationBarHidden(isNavBarHidden, animated: animated)
        let image = UIImage(named: "backArrow")?
            .withTintColor(.white, renderingMode: .alwaysOriginal)
        navigationItem.leftBarButtonItem = .init(
            image: image,
            style: .plain,
            target: self,
            action: #selector(didTapBack)
        )
    }
    
    @objc private func didTapBack() {
        navigationController?.popViewController(animated: true)
    }
}
