//
//  SideBarViewController.swift
//  iPadMenuList
//
//  Created by Ashlee Muscroft on 08/10/2020.
//

import UIKit

class SideBarViewController: UIViewController {
    var listItems: [ListItem] = []
    var collectionView: UICollectionView! = nil
    var dataSource: UICollectionViewDiffableDataSource<Section,ListItem>! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewHierarchy()
        //Build a configuration list for a fake sideBar
        configureDataSource()
    }
}

extension SideBarViewController {
    private func configureViewHierarchy() {
        let configuration = UICollectionLayoutListConfiguration(appearance: .sidebar)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        //self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
    }
    private func configureDataSource(){
        //populate our collectionView with our listItems using new iOS14 apis
        //UICellViewList and the content
        let uiCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell,ListItem>
        { (cell, indexPath, item) in
            //default configuration has a goto 'title' and 'image' which matches our list item perfectly
            var content = cell.defaultContentConfiguration()
            content.text = item.title
            content.image = item.image
            //adjust the cell content to match our actual liteItem structure
            cell.contentConfiguration = content
        }
        
        //use and call Diffable Datasource to use my items from listItems via a closure
        dataSource = UICollectionViewDiffableDataSource<Section,ListItem>(collectionView: collectionView)
        { (collectionView: UICollectionView, indexPath: IndexPath, item: ListItem) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using:uiCellRegistration,for: indexPath, item: item)
        }
        //snapshot for centrallized truth
        var snapshot = NSDiffableDataSourceSnapshot<Section,ListItem>()
        snapshot.appendSections([.main])
        //attempt to load menuItem from JSON
        generateMenuItemList()
        snapshot.appendItems(listItems)
        //TODO genereate footer section that contains Copyright, terms and privacy
        dataSource.apply(snapshot,animatingDifferences: true)
    }
}
//configure a listView with diffableDataSource
extension SideBarViewController {
    //extract potential list items from JSON
    var menuItems:MenuItems {
        get {
            return Bundle.main.decode(MenuItems.self, from: "menuitems.json")
        }
        set{}
    }
    
    func generateMenuItemList() {
        let mainMenu = self.menuItems
        if !mainMenu.menu.isEmpty {
            for item in mainMenu.menu {
                let altImage = item.altImage != nil
                    ? UIImage(systemName: item.altImage!) : nil
                listItems.append(
                    ListItem(
                        title: item.title,
                        image: UIImage(systemName: item.image),
                        altImage: altImage
                    )
                )
            }
        }
    }
}
