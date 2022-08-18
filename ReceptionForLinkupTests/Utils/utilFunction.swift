//
//  utilFunction.swift
//  ReceptionForLinkupTests
//
//  Created by 中出翔也 on 2022/08/18.
//

import XCTest
@testable import ReceptionForLinkup

class utilFunction: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUtilFunc_showMinToHour_ShouldReturn1h() {
        // Arrange
        let min = 60
        let hourAnswer = "1時間0分"
        
        // Act
        let showHour = showMinToHour(min: min)
        print("showHour: \(showHour)")
        
        // Assert
        XCTAssertTrue(showHour == hourAnswer, "The showHour should have returned \(hourAnswer) but returned not")
    }
    
    func testUtilFunc_showMinToHour_ShouldReturn1h1min() {
        // Arrange
        let min = 61
        let hourAnswer = "1時間1分"
        
        // Act
        let showHour = showMinToHour(min: min)
        print("showHour: \(showHour)")
        
        // Assert
        XCTAssertTrue(showHour == hourAnswer, "The showHour should have returned \(hourAnswer) but returned not")
    }
    func testUtilFunc_showMinToHour_ShouldReturn59min() {
        // Arrange
        let min = 59
        let hourAnswer = "59分"
        
        // Act
        let showHour = showMinToHour(min: min)
        print("showHour: \(showHour)")
        
        // Assert
        XCTAssertTrue(showHour == hourAnswer, "The showHour should have returned \(hourAnswer) but returned not")
    }
    func testUtilFunc_showMinToHour_ShouldReturn1h9min() {
        // Arrange
        let min = 69
        let hourAnswer = "1時間9分"
        
        // Act
        let showHour = showMinToHour(min: min)
        print("showHour: \(showHour)")
        
        // Assert
        XCTAssertTrue(showHour == hourAnswer, "The showHour should have returned \(hourAnswer) but returned not")
    }
    func testUtilFunc_showMinToHour_ShouldReturn1h59min() {
        // Arrange
        let min = 119
        let hourAnswer = "1時間59分"
        
        // Act
        let showHour = showMinToHour(min: min)
        print("showHour: \(showHour)")
        
        // Assert
        XCTAssertTrue(showHour == hourAnswer, "The showHour should have returned \(hourAnswer) but returned not")
    }

    func testUtilFunc_showMinToHour_ShouldReturn2h() {
        // Arrange
        let min = 120
        let hourAnswer = "2時間0分"
        
        // Act
        let showHour = showMinToHour(min: min)
        print("showHour: \(showHour)")
        
        // Assert
        XCTAssertTrue(showHour == hourAnswer, "The showHour should have returned \(hourAnswer) but returned not")
    }
    
}
