//
//  GitHubUsersReposUITests.swift
//  GitHubUsersReposUITests
//
//  Created by Sirisha Dudiki on 10/8/19.
//  Copyright © 2019 GitHubUsersRepos. All rights reserved.
//

import XCTest

class GitHubUsersReposUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }

    func testClickToDetailView() {

        let app = XCUIApplication()
        app.launch()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["mojombo"]/*[[".cells.staticTexts[\"mojombo\"]",".staticTexts[\"mojombo\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["GitHub Searcher"].buttons["Users"].tap()
    }

    func testSeachUsersClickToDetailView(){

        let app = XCUIApplication()
        app.launch()
        XCUIApplication()/*@START_MENU_TOKEN@*/.searchFields["Search for Users"]/*[[".otherElements[\"SearchUsers\"].searchFields[\"Search for Users\"]",".searchFields[\"Search for Users\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["sirishadudiki"]/*[[".cells.staticTexts[\"sirishadudiki\"]",".staticTexts[\"sirishadudiki\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["GitHubSearcher"]/*[[".cells.staticTexts[\"GitHubSearcher\"]",".staticTexts[\"GitHubSearcher\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.statusBars/*@START_MENU_TOKEN@*/.buttons["breadcrumb"]/*[[".buttons[\"Return to GitHubUsersRepos\"]",".buttons[\"breadcrumb\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["GitHub Searcher"].buttons["Users"].tap()

    }
}
