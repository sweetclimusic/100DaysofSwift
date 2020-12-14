//
//  CollectionViewCell.swift
//  bud
//
//  Created by Ashlee Muscroft on 30/11/2020.
//

import UIKit

@IBDesignable
class CollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "transaction-cell-reuse-identifier"
    @IBOutlet weak var productImageView: UIImageView?
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var seperatorView: UIView!
    @IBOutlet weak var itemAmount: UILabel!
    @IBOutlet weak var imageHighlightOverlay: UIView!
    var showSeperatorView: Bool = true {
        didSet {
            toggleSeperatorView()
        }
    }
    var defaultBackgroundColor: UIColor!
    var selectedBackgroundColor: UIColor!
    //override default is selected for highlighted text effect.
    override var isSelected: Bool {
        didSet {
            super.isSelected = self.isSelected
            self.backgroundColor = self.isSelected ? selectedBackgroundColor.withAlphaComponent(0.8) : defaultBackgroundColor
            imageHighlightOverlay.backgroundColor = backgroundColor
            imageHighlightOverlay.isHidden = !self.isSelected
        }
    }
    var item: TransactionItemModel? {
        didSet {
            if let item = item {
                setContentHuggingPriority(.defaultLow, for: .horizontal)
                productImageView?.image = item.image
                styleProductImageView()
                itemTitle.text = item.datumDescription
                itemAmount.text = item.amount
                itemDescription.text = item.category
            }
        }
    }
}
extension CollectionViewCell {
    func toggleSeperatorView(){
        seperatorView.isHidden = !showSeperatorView
    }
    func styleProductImageView() {
        productImageView?.layer.cornerRadius = 32
        productImageView?.layer.borderWidth = 1
        productImageView?.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        imageHighlightOverlay.layer.cornerRadius = 32
    }
}
