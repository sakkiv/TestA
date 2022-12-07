//
//  DescriptionViewModelTest.swift
//  TestATests
//
//  Created by vikas shankhdhar on 06/12/22.
//

import XCTest
@testable import TestA

class DescriptionViewModelTest: XCTestCase {
    
        var viewModel : ImageSwipeViewModel = ImageSwipeViewModel()
        var dataItem: [NasaHomeModel]?
        var currentIndex : Int = 0
  
    override func setUp() {
        currentIndex = viewModel.currentImage
        
       }
       override func tearDown() {

           super.tearDown()
       }
    
    
    func test_fetch_data() {
        let expectation = XCTestExpectation(description: "Successfully loaded  Nasa  Data ")
       // Given
        self.dataItem = viewModel.filteredData
        // Expectation
        self.articleAtIndex(){ status in
            expectation.fulfill()
         }
    }
  
    func testFetchWithNoService() {
        let expectation = XCTestExpectation(description: "No Nasa Data Availale")
        // Given
         self.dataItem = nil
        
        // Expectation
         self.articleAtIndex(){ status in
             expectation.fulfill()
          }
    }
    
    func testFetchWithMoveLeft() {
        let expectation = XCTestExpectation(description: "Data Availale at Swipe Left")
        // Given
        self.dataItem = viewModel.filteredData
        // Expectation
         self.articleSwipeLeftAtIndex(){ status in
             expectation.fulfill()
          }
        wait(for: [expectation], timeout: 5.0)
    }
    func testFetchWithMoveRight() {
        let expectation = XCTestExpectation(description: "Data Availale at Swipe Right")
        // Given
         self.dataItem = viewModel.filteredData
        // Expectation
         self.articleSwipeRightAtIndex(){ status in
             expectation.fulfill()
          }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchWithNoDataAtLeft() {
        let expectation = XCTestExpectation(description: "No Data Availale at Swipe Left")
        // Given
         self.dataItem = nil
        // Expectation
         self.articleSwipeLeftAtIndex(){ status in
             expectation.fulfill()
          }
        wait(for: [expectation], timeout: 5.0)
    }
    func testFetchWithNoDataAtRight() {
        let expectation = XCTestExpectation(description: "No Data Availale at Swipe Right")
        // Given
         self.dataItem = nil
        // Expectation
         self.articleSwipeRightAtIndex(){ status in
             expectation.fulfill()
          }
        wait(for: [expectation], timeout: 5.0)
    }
}

extension DescriptionViewModelTest : ImageSwipeViewModelProtocol {
    
    var numberOfSections: Int {
        return  self.dataItem?.count ?? 0
    }
    
    func articleAtIndex(completion: @escaping (NasaHomeModel) -> Void) {
        if let article = self.dataItem?[currentIndex] {
            completion(article)
        }
    }
    
    func articleSwipeLeftAtIndex(completion: @escaping (Int) -> Void) {
        if currentIndex ==  numberOfSections - 1 {
            currentIndex = 0
        }else{
            currentIndex = currentIndex + 1
        }
        completion(currentIndex)
    }
    
    func articleSwipeRightAtIndex(completion: @escaping (Int) -> Void) {
        if currentIndex == 0 {
            currentIndex = numberOfSections - 1
        }else{
            currentIndex -= 1
        }
        completion(currentIndex)
    }

}

