//
//  HomeViewModel.swift
//  TestATests
//
//  Created by vikas shankhdhar on 06/12/22.
//

import XCTest
@testable import TestA

class HomeViewModel: XCTestCase {

        var mockAPIService: MockCurrencyService!
        var viewModel : NasaHomeDataSource = NasaHomeDataSource(service: Services())
       
    override func setUp() {
           mockAPIService = MockCurrencyService()
           viewModel = NasaHomeDataSource(service: mockAPIService)
       }
       
       override func tearDown() {
           self.mockAPIService = nil
           super.tearDown()
       }
    
    
    func test_fetch_photo() {
        let expectation = XCTestExpectation(description: "Successfully loaded  Nasa  Data ")
       // Given
       mockAPIService.converter =  [NasaHomeModel]()
        viewModel.onErrorHandling = { _ in
            XCTAssert(false, "ViewModel should not be able to fetch without service")
        }
        // expected to fetch data successfully
        viewModel.fetchNasaData() {
        }
        viewModel.onSucessFullLoading = { [weak self] status in
            self?.viewModel.sortedData()
            expectation.fulfill()
        }
    }
  
    func testFetchWithNoService() {
        let expectation = XCTestExpectation(description: "No Nasa Data Availale")
        // giving no service to a view model
        viewModel.service = nil
        
        // expected to not be able to fetch data
        viewModel.onErrorHandling = { error in
            expectation.fulfill()
        }
        viewModel.fetchNasaData() {
        }
        wait(for: [expectation], timeout: 5.0)
    }
}

class MockCurrencyService : ServiceProtocol {

     var converter: [NasaHomeModel] = [NasaHomeModel]()
     var expectation: XCTestExpectation?
     func nasaData (completion: @escaping (Result<[NasaHomeModel]?, Error>) -> Void) {
        ServiceManager.shared.load(resource: NasaHomeModel.allFor()) { result in
            switch result {
                case .success(let ticketList):
                completion(.success(ticketList))
                    break
                case .failure((let error)):
                completion(.failure(error))
                    break
            }
            self.expectation?.fulfill()
        }
    }
}

