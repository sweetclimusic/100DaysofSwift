//
//  Authority.swift
//  fsa-infinity
//
//  Created by Ben Foster on 24/08/2020.
//  Copyright © 2020 InfinityWorks. All rights reserved.
//

import Foundation

public struct Authority: Codable {
    
    var id: Int
    var name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "LocalAuthorityId"
        case name = "Name"
    }
}

struct AuthoritiesResponse: Codable {
    var authorities: [Authority]
}
