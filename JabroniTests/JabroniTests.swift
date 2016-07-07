//
//  JabroniTests.swift
//  JabroniTests
//
//  Created by David Mattia on 7/6/16.
//  Copyright © 2016 South Bend Code School. All rights reserved.
//

import XCTest
@testable import Jabroni

class JabroniTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDataDownload() {
        let expectation = expectationWithDescription("Waiting for object to be created")
        
        User.fromSnapshotWithId("-KM2Qa7SEhvoJ32TLyS6", whenLoaded: {
            jabroniObject in
            if let user = jabroniObject as? User {
                XCTAssertNotNil(user.name)
                XCTAssertNotNil(user.age)
                expectation.fulfill()
            } else {
                XCTFail("Incorrect closure type")
            }
        })
        
        waitForExpectationsWithTimeout(5) { error in
            print(error)
        }
    }
}
