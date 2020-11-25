//
//  ViewController.swift
//  iPadSOAnswer
//
//  Created by Ashlee Muscroft on 08/10/2020.
//

import UIKit

class SideBarViewController: UIViewController {
    var listItems: [listItem]?
    override func viewDidLoad() {
        super.viewDidLoad()
        //Build a configuration list for a fake sideBar
        let configuration = UICollectionLayoutListConfiguration(appearance: .sidebar)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        //SF Symbols suitable for HOME
        listItems?.append(listItem(title: "House", image:UIImage(systemName:"house")!))
        listItems?.append(listItem(title: "Lights", image:UIImage(systemName:"lightbulb")!))
        listItems?.append(listItem(title: "Phone", image:UIImage(systemName:"phone")!))
        listItems?.append(listItem(title: "Music", image:UIImage(systemName:"music.note.house")!))
        listItems?.append(listItem(title: "Wifi", image:UIImage(systemName:"wifi")!))
        listItems?.append(listItem(title: "Video", image:UIImage(systemName:"tv")!))
        listItems?.append(listItem(title: "Apple TV", image:UIImage(systemName:"appletv")!))
        
        //populate are collectionView with our listItems using new iOS14 apis
        //UICellViewList and the content
        let uiCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell,listItem>
        { cell, indexPath, item in
            //default configuration has a goto 'title' and 'image' which matches our list item perfectly
            var content = cell.defaultContentConfiguration()
            content.text = item.title
            content.image = item.image
            //adjust the cell content to match our actual liteItem structure
            cell.contentConfiguration = content
        }
        
        //use and call Diffable Datasource to use my items from listItems via a closure
        let dataSource = UICollectionViewDiffableDataSource<Section,listItem>(collectionView: collectionView)
        { collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(using:uiCellRegistration,for: indexPath,item: item)
        }
        
    }


}

