//
//  PhotosUITests.swift
//  PhotosUITests
//
//  Created by 박진섭 on 2022/03/22.
//

import XCTest

class PhotosUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
        app.terminate()
        try super.tearDownWithError()
    }

    func testNavigationTitleIsValidate() throws {
        //check navigation bar title
        XCTAssertTrue(app.navigationBars.staticTexts["Photos"].exists)
    }

}
