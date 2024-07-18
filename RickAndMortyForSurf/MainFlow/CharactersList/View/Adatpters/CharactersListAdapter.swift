import UIKit

final class CharactersListAdapter {
    typealias CharactersListDataSourse = UICollectionViewDiffableDataSource<Section, CharacterCellModel>
    
    private let collectionView: UICollectionView
    private var dataSourse: CharactersListDataSourse?
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        self.dataSourse = createDataSourse()
    }
    
    func update(with model: CharactersWithSectionModel) {
        guard var snapshot = dataSourse?.snapshot() else { return }
        snapshot.deleteAllItems()
        snapshot.appendSections([model.section])
        snapshot.appendItems(model.characters)
        dataSourse?.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: - Private extension -
private extension CharactersListAdapter {
    func createDataSourse() -> CharactersListDataSourse {
        let dataSourse = CharactersListDataSourse(
            collectionView: collectionView) { collectionView, indexPath, characterModel in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CharacterCell.self)", for: indexPath) as? CharacterCell else {
                    print("error: Cell")
                    return UICollectionViewCell()
                }
                cell.updateUI(with: characterModel)
                return cell
            }
        
        return dataSourse
    }
}

extension CharactersListAdapter {
    enum Section: Int, Hashable {
        case mane
    }
}
