//
//  RatingCell.swift
//  fsa-infinity
//
//  Created by Ben Foster on 25/08/2020.
//  Copyright © 2020 InfinityWorks. All rights reserved.
//

import UIKit

class RatingCell: UITableViewCell {
    
    static let identifier = "RatingCell"
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingPercentage: UILabel!
    
    func display(rating: String, percentage: String) {
        ratingLabel.text = rating
        ratingPercentage.text = percentage
    }
}
