//
//  MenuItemModel.swift
//  iPadMenuList
//
//  Created by Ashlee Muscroft on 27/11/2020.
//

// JSON model create on https://app.quicktype.io parse from menuitems.json
//   let menuItems = try? newJSONDecoder().decode(MenuItems.self, from: jsonData)

import Foundation

// MARK: - MenuItems
struct MenuItems: Codable {
    let menu: [Menu]
    let cc, terms, privacy: String
}

// MARK: - Menu
struct Menu: Codable {
    let title, image: String
    let altImage: String?

    enum CodingKeys: String, CodingKey {
        case title, image
        case altImage = "alt-image"
    }
}
