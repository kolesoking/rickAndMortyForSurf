import Foundation
import UIKit

final class CharactersListBuilder {
    var viewController: UIViewController {
        return CharactersListViewController(viewModel: viewModel)
    }
    
    private var viewModel: CharactersListViewModel {
        return CharactersListDefaultViewModel(networkService: networkService)
    }
    
    private var networkService: NetworkService {
        return NetworkServiceImpl()
    }
}
