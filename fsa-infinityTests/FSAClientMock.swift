//
//  FSAClientMock.swift
//  FSAInfinity
//
//  Created by Ben Foster on 25/08/2020.
//  Copyright © 2020 InfinityWorks. All rights reserved.
//

import Foundation
import InfinityFSA

class FSAClientMock: FSAClientProtocol {
    func getAuthorities(resultHandler: @escaping ([Authority]) -> Void) {
        let testAuthority = Authority(id: 101, name: "Test Authority")
        resultHandler([testAuthority])
    }
}
