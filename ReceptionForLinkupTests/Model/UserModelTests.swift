//
//  UserModelValidatorTests.swift
//  ReceptionForLinkupTests
//
//  Created by 中出翔也 on 2022/08/13.
//

import XCTest
@testable import ReceptionForLinkup

class UserModelTests: XCTestCase {
    var sut: User = User()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = User()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testUserModelValidator_WhenEstimatedUseTime_ShouldReturnTime() {
        // Arrange
        let correctInterval = 70
        let correctModifiedDate = Calendar.current.date(byAdding: .minute, value: -correctInterval, to: Date())!
        let wrongModifiedDate = Calendar.current.date(byAdding: .minute, value: -correctInterval + 10, to: Date())!
        
        // Act
        sut.inTime = correctModifiedDate
        let isEstimatedCorrectTimeInt = sut.estimatedUseTime(now: Date())
        sut.inTime = wrongModifiedDate
        let isEstimatedWrongTimeInt = sut.estimatedUseTime(now: Date())
        
        // Assert
        XCTAssertTrue(isEstimatedCorrectTimeInt == correctInterval, "The isEstimatedTimeInt should have returned \(correctInterval)  but returned not")
        XCTAssertFalse(isEstimatedWrongTimeInt == correctInterval, "The isEstimatedTimeInt should have returned \(correctInterval) + alpha,  but returned  \(correctInterval) ")
    }
    
    func testUserModelValidator_WhenUseTime_ShouldReturnError() {
        // Arrange
        
        // Act
        let isInvalidTime = sut.useTime() // -1
        sut.outTime = Date() // nil -> not nil
        let isValidTime = sut.useTime() // 0
        
        // Assert
        XCTAssertTrue(isInvalidTime == -1, "The isInvalidTime should have returned -1 but returned not")
        XCTAssertTrue(isValidTime != -1, "The isValidTime should have returned 0 but returned -1")
    }

    
    func testUserModelValidator_WhenEstimatedPayment_ShouldReturn500() {
        // Arrange
        let Interval = 59
        let modifiedDate = Calendar.current.date(byAdding: .minute, value: -Interval, to: Date())!
        sut.persons = 1
        sut.isPassUser = false
        sut.inTime = modifiedDate
        sut.outTime = Date()
        
        // Act
        let payment = sut.payment()
        print("payment: \(payment)")
        
        // Assert
        XCTAssertTrue(payment == 500, "The isInvalidTime should have returned 500 but returned not")
    }
    
    func testUserModelValidator_WhenEstimatedPayment_ShouldReturn800() {
        // Arrange
        let Interval = 70
        let modifiedDate = Calendar.current.date(byAdding: .minute, value: -Interval, to: Date())!
        sut.persons = 1
        sut.isPassUser = false
        sut.inTime = modifiedDate
        sut.outTime = Date()
        
        // Act
        let payment = sut.payment()
        print("payment: \(payment)")
        
        // Assert
        XCTAssertTrue(payment == 800, "The isInvalidTime should have returned 800 but returned not")
    }
    
    func testUserModelValidator_WhenEstimatedPayment_ShouldReturn1000() {
        // Arrange
        let Interval = 121
        let modifiedDate = Calendar.current.date(byAdding: .minute, value: -Interval, to: Date())!
        sut.persons = 1
        sut.isPassUser = false
        
        // Act
        sut.inTime = modifiedDate
        sut.outTime = Date()
        let payment = sut.payment()
        print("payment: \(payment)")
        
        // Assert
        XCTAssertTrue(payment == 1000, "The isInvalidTime should have returned 1000 but returned not")
    }
    
    
    func testUserModelValidator_WhenEstimatedPayment_ShouldReturn1300() {
        // Arrange
        let Interval = 240
        let modifiedDate = Calendar.current.date(byAdding: .minute, value: -Interval, to: Date())!
        sut.persons = 1
        sut.isPassUser = false
        sut.inTime = modifiedDate
        sut.outTime = Date()
        
        // Act
        let payment = sut.payment()
        print("payment: \(payment)")
        
        // Assert
        XCTAssertTrue(payment == 1300, "The isInvalidTime should have returned 1300 but returned not")
    }
    
    func testUserModelValidator_WhenEstimatedPayment_ShouldReturn2500() {
        // Arrange
        let Interval = 50
        let modifiedDate = Calendar.current.date(byAdding: .minute, value: -Interval, to: Date())!
        sut.persons = 5
        sut.isPassUser = false
        sut.inTime = modifiedDate
        sut.outTime = Date()
        
        // Act
        let payment = sut.payment()
        print("payment: \(payment)")
        
        // Assert
        XCTAssertTrue(payment == 2500, "The isInvalidTime should have returned 500 * 5 but returned not")
    }
    
}
