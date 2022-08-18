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
extension HomeView: Inspectable {}
extension ThankYouView: Inspectable {}

class ReceptionForLinkupViewTest: XCTestCase {

    override func setUpWithError() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // Arrange
        let thankview = ThankYouView(){}
        
        // Act
        let inspectedText = try thankview.inspect().find(text: "ありがとうございました！\nまたのご利用をお待ちしています")
        let inspectedView = try thankview.inspect().find(viewWithId: "thank_text")
        let fontStyle = try inspectedView.text().attributes().font().style()
        //        let fontStyle = try inspectedText.attributes().font().style()
        
        // Assert
        XCTAssertEqual(fontStyle, .largeTitle)
    }
    
    func testHome() throws {
        // Arrange
        let view = HomeView(repository: UserRepositoryStub())
        
        // Act
        let inspectedView = try view.inspect().find(text: "test")
        let fontStyle = try inspectedView.attributes().font().style()
        
        // Assert
        XCTAssertEqual(fontStyle, .body)

    }

}
