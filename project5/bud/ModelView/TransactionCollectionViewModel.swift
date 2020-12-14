//
//  TransactionCollectionViewModel.swift
//  bud
//
//  Created by Ashlee Muscroft on 29/11/2020.
//

import Foundation
import UIKit

class TransactionCollectionViewModel {
    enum Section {
        case main
    }
    // MARK - Type Values
    typealias DataSource = UICollectionViewDiffableDataSource <Section,TransactionItemModel>

    typealias Snapshot = NSDiffableDataSourceSnapshot<Section,TransactionItemModel>
    
    // MARK - Data Model
    var dataSource: DataSource!
    var initSnapShot: Snapshot!
    var uiCollectionViewBackgroundSelectedColor: UIColor = UIColor(red: 250/255, green: 118/255, blue: 120/255, alpha: 1.0)
    var uiCollectionViewCellSelectedTextColor: UIColor = .white
    
}
extension TransactionCollectionViewModel {
    // MARK - establishes dataSource for diffableTable and the reusableCell.
    func configureDataSource(collectionView: UICollectionView, listItems: [TransactionItemModel]) {
        dataSource = DataSource(collectionView: collectionView) {
            //using custom cell
            collectionView, indexPath, item -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier, for: indexPath) as! CollectionViewCell
            cell.item = item
            //perform additional image Download for icon image
            self.downloadProductIcon(urlString: item.imageUrl, item: item) { image in
                cell.productImageView?.image = image
            }
            cell.defaultBackgroundColor = self.uiCollectionViewCellSelectedTextColor
            cell.selectedBackgroundColor = self.uiCollectionViewBackgroundSelectedColor
            cell.showSeperatorView = indexPath.item !=  listItems.count - 1
            return cell
        }
    }
    // MARK - Diffable DataSource Snapshot helper function
    func applySnapshotToSection(listItems: [TransactionItemModel], section: Section = .main) {
        var currentSnapshot = Snapshot()
        currentSnapshot.appendSections([.main])
        currentSnapshot.appendItems(listItems, toSection: section)
        dataSource.apply(currentSnapshot, animatingDifferences: true)
    }
    
    func deleteSelectFromSnapshotForSection(selectedListItems: [TransactionItemModel], section: Section = .main) {
        //capture current state of dataSource
        var currentSnapshot = dataSource.snapshot()
        currentSnapshot.deleteItems(selectedListItems)
        dataSource.apply(currentSnapshot, animatingDifferences: true)
    }
    
    /// prefetch image downloader of the decode json product.icon
    /// - Parameters    urlString: String item icon url location
    ///               item: TransactionItemModel current item being added to the cell
    ///               completion: @escaping(UIImage) used to before assignment of new image on current cell as a closure function of download complete
    func downloadProductIcon(urlString: String, item: TransactionItemModel, completion: @escaping(UIImage) -> Void) {
        //perform additional image Download for icon image
        guard let url = URL(string: urlString ) else {
            fatalError("no url string")
        }

        URLSession.shared.downloadTask(with: url) { url, response, error in
            guard let fileCache = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first,
                  let url = url, error == nil else {
                return
            }
            let file = fileCache.appendingPathComponent("\(UUID().uuidString).jpg")
            try? FileManager.default.moveItem(atPath: url.path, toPath: file.path)
                    let image = UIImage(contentsOfFile: file.path)
                    if let image = image {
                        //save to cache
                        cache.setObject(image, forKey: item.imageUrl as NSString)
                        DispatchQueue.main.async {
                            //cell.productImageView?.image = image
                            completion(image)
                        }
                    }
               
        }.resume()
    }
    
}
