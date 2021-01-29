//
//  fsa_infinityTests.swift
//  fsa-infinityTests
//
//  Created by Ben Foster on 24/08/2020.
//  Copyright © 2020 InfinityWorks. All rights reserved.
//

import XCTest
@testable import InfinityFSA

class AuthoritiesViewControllerTests: XCTestCase {

    var controller: AuthoritiesViewController?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let clientMock: FSAClientProtocol = FSAClientMock() as FSAClientProtocol
        controller = AuthoritiesViewController()
        controller?.fsaClient = clientMock
    }
    
    func testSetClientAuthoritiesResult() {
        
        controller?.viewDidLoad()
        XCTAssertEqual(1, controller?.authorities?.count)
        
        let actualAuthority = controller?.authorities?[0]
        
        XCTAssertEqual(101, actualAuthority?.id)
        XCTAssertEqual("Test Authority", actualAuthority?.name)
    }

}
