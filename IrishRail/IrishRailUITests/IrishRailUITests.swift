//
//  IrishRailUITests.swift
//  IrishRailUITests
//
//  Created by Daniel Colnaghi on 10/08/2018.
//  Copyright © 2018 Daniel Colnaghi. All rights reserved.
//

import XCTest

class IrishRailUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testUI() {
        
        let app = XCUIApplication()
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Schedule"].tap()
        tabBarsQuery.buttons["Stations"].tap()
        tabBarsQuery.buttons["Direction"].tap()        
    }
    
}
