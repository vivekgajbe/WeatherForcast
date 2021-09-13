//
//  CheckDecimalTests.swift
//  WeatherAppDemoTests
//
//  Created by vivek G on 13/09/21.
//

import XCTest
@testable import WeatherAppDemo

class CheckDecimalTests: XCTestCase {
    func testMoneyFormmaterWholeNumber()
    {
//        let obj = clsCityEntity()
//        print(Decimal(string: "0")?.TwoDigitNumber)
        
        XCTAssertEqual( Decimal(string: "0")?.TwoDigitNumber, "0.00")
        XCTAssertEqual( Decimal(string: "1")?.TwoDigitNumber, "1.00")
        XCTAssertEqual( Decimal(string: "2")?.TwoDigitNumber, "2.00")
        XCTAssertEqual( Decimal(string: "3")?.TwoDigitNumber, "3.00")
        XCTAssertEqual( Decimal(string: "10")?.TwoDigitNumber, "10.00")
    }
    
    func testMoneyFormatterDecimalNumberWithOneDecimalPlace()
    {
//        let obj = clsCityEntity()
        XCTAssertEqual( Decimal(string: "1.1")?.TwoDigitNumber, "1.10")
        XCTAssertEqual( Decimal(string: "1.2")?.TwoDigitNumber, "1.20")
        XCTAssertEqual( Decimal(string: "1.3")?.TwoDigitNumber, "1.30")
    }
    
    func testMoneyFormatterDecimalNumberWithTwoDecimalPlace()
    {
//        let obj = clsCityEntity()
        XCTAssertEqual( Decimal(string: "1.11")?.TwoDigitNumber, "1.11")
        XCTAssertEqual( Decimal(string: "1.22")?.TwoDigitNumber, "1.22")
        XCTAssertEqual( Decimal(string: "1.33")?.TwoDigitNumber, "1.33")
        XCTAssertEqual( Decimal(string: "-99.33")?.TwoDigitNumber, "-99.33")
    }
   func testMoneyFormatterDecimalNumberWithAnyDecimalPlace()
   {
//       let obj = clsCityEntity()
    XCTAssertEqual( Decimal(string: "1.111")?.TwoDigitNumber, "1.11")
    XCTAssertEqual(Decimal(string: "1.222")?.TwoDigitNumber, "1.22")
    XCTAssertEqual(Decimal(string: "1.33z1234")?.TwoDigitNumber, "1.33")
    XCTAssertEqual(Decimal(string: "-99.33123")?.TwoDigitNumber, "-99.34")
   }

}
