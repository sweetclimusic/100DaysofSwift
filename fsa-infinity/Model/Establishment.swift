//
//  Establishment.swift
//  FSAInfinity
//
//  Created by Ashlee Muscroft on 21/01/2021.
//  Copyright © 2021 InfinityWorks. All rights reserved.
//

import Foundation

public struct Establishments: Codable {
    var establishments: [Establishment]
}

public struct Establishment: Codable {
    var id: String
    var rating: String

    enum CodingKeys: String, CodingKey {
        case id = "LocalAuthorityBusinessID"
        case rating = "RatingValue"
    }
}

