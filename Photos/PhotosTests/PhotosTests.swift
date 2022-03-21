//
//  PhotosTests.swift
//  PhotosTests
//
//  Created by 안상희 on 2022/03/21.
//

import XCTest

class PhotosTests: XCTestCase {
    var sut: RGB!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = RGB.init(red: 10, green: 10, blue: 10)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testGenerateRandomColor() {
        let testRGB = sut
        
        for _ in 0..<100 {
            let randomRGB = RGB.generateRandomColor()
            XCTAssertNotEqual(testRGB, randomRGB)
        }
    }
}
