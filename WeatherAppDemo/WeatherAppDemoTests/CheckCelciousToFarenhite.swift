//
//  CheckCelciousToFarenhite.swift
//  WeatherAppDemoTests
//
//  Created by vivek G on 14/09/21.
//

import XCTest
@testable import WeatherAppDemo

class CheckCelciousToFarenhite: XCTestCase {

    func testCelciousToFarenheit()
    {
//        let obj = clsCityEntity()
//        print(Decimal(string: "0")?.TwoDigitNumber)
        
        XCTAssertEqual( Decimal(string: "1")?.celciousToFarenheit, "33.80")
        XCTAssertEqual( Decimal(string: "2")?.celciousToFarenheit, "35.60")
        XCTAssertEqual( Decimal(string: "3")?.celciousToFarenheit, "37.40")
        XCTAssertEqual( Decimal(string: "0")?.celciousToFarenheit, "32.00")
        XCTAssertEqual( Decimal(string: "-1")?.celciousToFarenheit, "30.20")
    }

    func testFarenheitToCelcious()
    {
//        let obj = clsCityEntity()
//        print(Decimal(string: "0")?.TwoDigitNumber)
        
        XCTAssertEqual( Decimal(string: "32")?.FarenheitToCelcious, "0.00")
        XCTAssertEqual( Decimal(string: "37.4")?.FarenheitToCelcious, "2.99")
        XCTAssertEqual( Decimal(string: "30.20")?.FarenheitToCelcious, "-1.00")
        XCTAssertEqual( Decimal(string: "33.80")?.FarenheitToCelcious, "0.99")
    }
}
