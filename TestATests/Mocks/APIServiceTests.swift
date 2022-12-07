//
//  APIServiceTests.swift
//  TestATests
//
//  Created by vikas shankhdhar on 06/12/22.
//

@testable import TestA
import XCTest
class APIServiceTests: XCTestCase {
    
    var sut: Services?
    
    override func setUp() {
        super.setUp()
        sut = Services()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_fetch_popular_photos() {
        // Given A apiservice
        let sut = self.sut!
        // When fetch Nasa  photo
        let expect = XCTestExpectation(description: "callback")
        sut.nasaData { response  in
            switch(response) {
            case .success(let res):
                guard let response = res else {
                    XCTAssertNil("Missing service")
                    return
                }
                expect.fulfill()
                XCTAssertGreaterThan(response.count, 0)
                break;
            case .failure(let error):
                XCTAssertTrue(true, error.localizedDescription)
                break
            }
        }
        wait(for: [expect], timeout: 3.1)
    }
    
}
