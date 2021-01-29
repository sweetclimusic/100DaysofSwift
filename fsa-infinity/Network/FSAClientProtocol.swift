//
//  FSAClientProtocol.swift
//  FSAInfinity
//
//  Created by Ben Foster on 25/08/2020.
//  Copyright © 2020 InfinityWorks. All rights reserved.
//

import Foundation

public protocol FSAClientProtocol {
    
    func getAuthorities(resultHandler: @escaping ([Authority]) -> Void)
    func getEstablishmentByAuthority(authorityId: Int, resultHandler: @escaping ([Establishment]) -> Void)
}
