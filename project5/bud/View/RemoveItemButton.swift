//
//  RemoveItemButton.swift
//  bud
//
//  Created by Ashlee Muscroft on 30/11/2020.
//

import UIKit

protocol RemoveSelectedItemDelegate {
    func removeItems(button:UIButton)
}

class RemoveItemButton: UIButton {
    var delegate: RemoveSelectedItemDelegate!
    var editMode: Bool = true {
        didSet {
            toggleHidden()
        }
    }
    override init(frame: CGRect){
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle("Remove", for: .normal)
        self.addTarget(self, action: #selector(toggleEditMode), for: .touchUpInside)
        self.isHidden = true
        contentMode = .scaleToFill
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
extension RemoveItemButton {
    fileprivate func toggleHidden() {
        self.isHidden = !self.isHidden
    }
    @objc func toggleEditMode(button:UIButton){
        delegate.removeItems(button: button)
    }
}
