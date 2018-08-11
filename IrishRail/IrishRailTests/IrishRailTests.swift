//
//  IrishRailTests.swift
//  IrishRailTests
//
//  Created by Daniel Colnaghi on 10/08/2018.
//  Copyright © 2018 Daniel Colnaghi. All rights reserved.
//

import XCTest
@testable import IrishRail

class IrishRailTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func waitForIt() {
        waitForExpectations(timeout: 5) { (error) in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testStationsWithType() {
        let exp = expectation(description: "Get data from API")
        
        IrishRailAPI.shared.getAllStationsWithType("A", success: { (stationList) in
            XCTAssert(stationList.count > 0, "Station count test")
            exp.fulfill()
        }) { (error) in
            XCTFail("Error loading stations from API")
            exp.fulfill()
        }
        
        waitForIt()
    }
    
    func testStationSchedules() {
        let exp = expectation(description: "Get data from API")
        
        IrishRailAPI.shared.getStationDataByName("Blackrock", success: { (stationList) in
            XCTAssert(stationList.count > 0, "Station schedule count test")
            exp.fulfill()
        }) { (error) in
            XCTFail("Error loading stations from API")
            exp.fulfill()
        }
        
        waitForIt()
    }
}
