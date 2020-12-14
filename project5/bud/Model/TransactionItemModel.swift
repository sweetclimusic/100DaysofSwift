//
//  TransactionItem.swift
//  bud
//
//  Created by Ashlee Muscroft on 29/11/2020.
//  The model to define the contents of a cell in the transaction list

import Foundation
import UIKit

struct TransactionItemModel: Hashable {
    // Hashability conformence using a Unquie Identifier and hash value allows diffableDataSource to track changes
    var image: UIImage
    let amount: String
    let id, //UUID provided from JSON source
        datumDescription,
        category: String
    let date: Date
    let imageUrl: String
    
    func hash(into hasher: inout Hasher){
        hasher.combine(id)
    }
    
    static func == (lhs: TransactionItemModel, rhs: TransactionItemModel) -> Bool {
        return lhs.id == rhs.id
    }
}
