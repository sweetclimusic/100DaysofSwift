//
//  ConfigureView.swift
//  bud
//
//  Created by Ashlee Muscroft on 29/11/2020.
//  Configure the apps UIController views

import Foundation
import UIKit

class ConfigureView {
    var uiNavControllerBackgroundColor: UIColor!
    var uiNavControllerTextColor: UIColor!
    var uiCollectionViewBackgroundColor: UIColor!
    var uiCollectionViewCellTextColor: UIColor!
    var uiCollectionViewBackgroundSelectedColor: UIColor!
    var uiCollectionViewCellSelectedTextColor: UIColor!
    var uiRemoveButtonBackgroundColor: UIColor!
    var uiRemoveButtonTintColor: UIColor!
    
    func configureAppTheme(){
        uiNavControllerBackgroundColor = .black
        uiNavControllerTextColor = .white
        uiCollectionViewBackgroundColor = .white
        uiCollectionViewCellTextColor = .black
        uiCollectionViewBackgroundSelectedColor = UIColor(red: 250/255, green: 118/255, blue: 120/255, alpha: 1.0)
        uiCollectionViewCellSelectedTextColor = .white
        uiRemoveButtonBackgroundColor = .systemRed
        uiRemoveButtonTintColor = .white
    }
    
    init() {
        configureAppTheme()
    }
    
    @available(*, unavailable )
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
