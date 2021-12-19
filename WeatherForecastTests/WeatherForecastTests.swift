//
//  WeatherForecastTests.swift
//  WeatherForecastTests
//
//  Created by Hoang Le on 19/12/2021.
//

import XCTest
@testable import WeatherForecast

class WeatherForecastTests: XCTestCase {
    private let service = WeatherService()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testGettingJSON() {
        let ex = expectation(description: "Expecting a JSON data not nil")
        service.downloadForecastData(forCity: "Saigon") { (forecasts, error)  in
            XCTAssertNil(error)
            XCTAssertNotNil(forecasts)
            ex.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }
    
}
