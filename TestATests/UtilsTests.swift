//
//  UtilsTests.swift
//  TestATests
//
//  Created by vikas shankhdhar on 06/12/22.
//

@testable import TestA
import XCTest

class UtilsTests: XCTestCase {
    
    func testUrlStringShouldReturnValidUrl() {
        let urlString = Domain.baseUrl()
        guard let url = URL(string: urlString) else {
            XCTFail("Url error!")
            return
        }
        let validUrl = url
        XCTAssertNotNil(validUrl)
        XCTAssertEqual(validUrl, url)
    }

    func testNilUrlStringShouldReturnNil() {
        let urlString: String? = nil
        XCTAssertNil(urlString)
    }
}
