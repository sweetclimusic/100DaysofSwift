//
//  ViewController.swift
//  bud
//
//  Created by Ashlee Muscroft on 29/11/2020.
//

import UIKit

class ViewController: UIViewController {
    var editMode = false
    var editButton: NavBarEditButton!
    var removeButton: RemoveItemButton!
    var collectionView: UICollectionView!
    var collectionViewCell: CollectionViewCell!
    var appTheme: ConfigureView = ConfigureView()
    var dataSourceModel = TransactionCollectionViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureViewHierachy()
        configureButtons()
        configureDataSource()
        applyConstraints()
        applyAppTheming()
    }


}
extension ViewController {
    func applyAppTheming() {
        navigationController?.navigationBar.barStyle = .black
        let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = appTheme.uiNavControllerBackgroundColor
            appearance.titleTextAttributes = [.foregroundColor: appTheme.uiNavControllerTextColor as UIColor]
            appearance.largeTitleTextAttributes = [.foregroundColor: appTheme.uiNavControllerTextColor as UIColor]
            navigationController?.navigationBar.barTintColor = appTheme.uiNavControllerBackgroundColor
            navigationController?.navigationBar.tintColor = appTheme.uiNavControllerTextColor
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        collectionView.backgroundColor = appTheme.uiCollectionViewBackgroundColor
        removeButton.tintColor = appTheme.uiRemoveButtonTintColor
        removeButton.backgroundColor = appTheme.uiRemoveButtonBackgroundColor
    }
    func applyConstraints() {
        NSLayoutConstraint.activate([
            removeButton.heightAnchor.constraint(equalToConstant: 50),
            removeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            removeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            removeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: removeButton.safeAreaLayoutGuide.topAnchor, constant: 50)
                                                   
        ])

    }
    func configureViewHierachy() {
        title = "Transactions"
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.allowsSelection = false
        //load nib Register cell classes
        let nib = UINib(nibName: "transactionCell", bundle: nil)
        collectionView!
            .register(nib, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureDataSource(){
        let transactions = TransactionItemViewModel()
        transactions.completionDelegate = self
        //use and call Diffable Datasource to use my items from listItems via a closure
        dataSourceModel.configureDataSource(collectionView: collectionView, listItems: transactions.transactionList)
        //gather the JSON and attempt to populate the UICollectionView on main section
        dataSourceModel.applySnapshotToSection(listItems: transactions.transactionList)
    }
}
extension ViewController: EditModeDelegate, RemoveSelectedItemDelegate {
    func removeItems(button: UIButton) {
        editMode = !editMode
        if let selectedIndexPaths = collectionView.indexPathsForSelectedItems {
            var deletableItems: [TransactionItemModel] = []
            for indexPath in selectedIndexPaths {
                if let item = dataSourceModel.dataSource.itemIdentifier(for: indexPath){
                    deletableItems.append(item)
                }
            }
            dataSourceModel.deleteSelectFromSnapshotForSection(selectedListItems: deletableItems)
        }
        updateCollectionEditMode()
        updateDelegates()
    }
    
    func editModeEnabled(button: UIButton) {
        editMode = !editMode
        updateCollectionEditMode()
        updateDelegates()
    }
    func updateCollectionEditMode() {
        collectionView.isEditing = editMode
        collectionView.allowsSelection = editMode
        collectionView.allowsMultipleSelectionDuringEditing = editMode
    }
    
    func updateDelegates() {
        editButton.editMode = editMode
        removeButton.editMode = editMode
    }
    
    func configureButtons() {
        editButton = NavBarEditButton()
        editButton.delegate = self
        navigationItem.rightBarButtonItem = editButton
        
        removeButton = RemoveItemButton(frame: view.frame)
        removeButton.delegate = self
        view.addSubview(removeButton)
        view.bringSubviewToFront(removeButton)
        
    }
}

extension ViewController: ListDownloadCompletionDelegate {
    func listDownLoadCompleted(_ listItems: [TransactionItemModel]) {
        dataSourceModel.applySnapshotToSection(listItems: listItems)
    }
}
