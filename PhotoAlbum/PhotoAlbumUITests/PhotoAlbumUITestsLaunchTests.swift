//
//  PhotoAlbumUITestsLaunchTests.swift
//  PhotoAlbumUITests
//
//  Created by 박진섭 on 2022/03/22.
//

import XCTest

class PhotoAlbumUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
