//
//  APITests.swift
//  SurveyExampleTests
//
//  Created by Abhishek Chaudhari on 22/12/19.
//  Copyright © 2019 Abhishek Chaudhari. All rights reserved.
//

import XCTest
@testable import SurveyExample

class APITests: XCTestCase {

    func testAuthAPI() {
        var token: String?
        let expect = expectation(description: "apiwait")
        
        AuthManager.shared.fetchToken { (result) in
            switch result{
            case .success(let res):
                token = res
            case .failure(_):
                XCTFail()
            }
            expect.fulfill()   
        }
        
        waitForExpectations(timeout: 5.0) { (error) in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
        XCTAssertNotNil(token)
    }

    func testFetchAPI() {
        var surveys: [Survey]?
        let expect = expectation(description: "apiwait")
        
        APIManager.shared.fetchSurverys(pageNumber: 1, numebrOfSurverys: 1) { (result) in
            switch result{
            case .success(let res):
                surveys = res
            case .failure(_):
                XCTFail()
            }
            expect.fulfill()
        }

        waitForExpectations(timeout: 5.0) { (error) in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
        XCTAssertNotNil(surveys)
        XCTAssertTrue(surveys?.count == 1)
    }

}
