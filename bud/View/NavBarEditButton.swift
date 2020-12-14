//
//  NavBarEditButton.swift
//  bud
//
//  Created by Ashlee Muscroft on 30/11/2020.
//

import UIKit

protocol EditModeDelegate {
    func editModeEnabled(button:UIButton)
}

class NavBarEditButton: UIBarButtonItem {
    var delegate: EditModeDelegate!
    var editMode: Bool = true {
        didSet {
            toggleTitle()
        }
    }
    override init(){
        super.init()
        style = .plain
        target = self
        action = #selector(toggleEditMode)
        title = "Edit"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func toggleTitle() {
        self.title = editMode ? "Done" : "Edit"
    }
    
    @objc func toggleEditMode(button:UIButton){
        delegate.editModeEnabled(button: button)
    }
}
