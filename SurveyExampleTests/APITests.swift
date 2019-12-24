//
//  APITests.swift
//  SurveyExampleTests
//
//  Created by Abhishek Chaudhari on 22/12/19.
//  Copyright © 2019 Abhishek Chaudhari. All rights reserved.
//

import XCTest
@testable import SurveyExample


let correctJson = #"[{"id":"d5de6a8f8f5f1cfe51bc","title":"Scarlett Bangkok","description":"We'd love ot hear from you!","cover_image_url":"https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_"}]"#

let correctAuthJson = #"{"access_token":"44f00eefc406e7efd1a4400f68603f8c61760a15cb0590fa8ca1b3c46de584f5","token_type":"bearer","expires_in":7200,"created_at":1577197012}"#

class APITests: XCTestCase {

    func testAuthAPI() {
        let data = correctAuthJson.data(using: .utf8)!
        let authObj = data.processData(classType: AuthModel.self) as? AuthModel
        XCTAssertNotNil(authObj)
        XCTAssertNotNil(authObj?.access_token)
    }
    
    func testFetchAPIData() {
        let data = correctJson.data(using: .utf8)!
        let surveys = data.processData(classType: [Survey].self) as? [Survey]
        XCTAssertNotNil(surveys)
        XCTAssertTrue(surveys?.count == 1)
    }
}
