//
//  SideBarItems.swift
//  iPadMenuList
//
//  Created by Ashlee Muscroft on 08/10/2020.
//

import Foundation
import UIKit

struct ListItem: Hashable {
    let title: String
    let image: UIImage?
    let altImage: UIImage?
    // Hashability conformence using a Unquie Identifier and hash value allows diffableDataSource to track changes
    let identifier = UUID()
    
    func hash(into hasher: inout Hasher){
        hasher.combine(identifier)
    }
    
    static func == (lhs: ListItem, rhs: ListItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

//Only one section too defined
enum Section {
  case main
}
