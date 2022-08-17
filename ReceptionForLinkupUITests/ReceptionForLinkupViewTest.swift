//
//  ReceptionForLinkupViewTest.swift
//  ReceptionForLinkupUITests
//
//  Created by 中出翔也 on 2022/08/14.
//

import XCTest
import SwiftUI
@testable import ReceptionForLinkup
import ViewInspector
extension ThankYouView: Inspectable {}
extension ContentTestView: Inspectable {}

class ReceptionForLinkupViewTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

//        let view = ThankYouView(){}
        let view = ContentTestView()
        let thankview = ThankYouView(){}
        let inspectedName = try view.inspect().find(text: "Hello, World!")
        let inspectedName2 = try thankview.inspect().find(text: "ありがとうございました！\nまたのご利用をお待ちしています")
//        let expected = "it lives!"
//        let sut = Text(expected)
//        let value = try sut.inspect().text().string()

        let fontStyle = try inspectedName.attributes().font().style()
        let fontStyle2 = try inspectedName2.attributes().font().style()
        XCTAssertEqual(fontStyle, .body)
        XCTAssertEqual(fontStyle2, .largeTitle)
//        XCTAssertEqual(value, expected)
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
