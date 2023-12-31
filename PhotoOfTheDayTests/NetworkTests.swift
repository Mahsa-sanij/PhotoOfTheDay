//
//  NetworkTests.swift
//  PhotoOfTheDayTests
//
//  Created by Mahsa Sanij on 10/14/23.
//

import XCTest
import Combine
@testable import PhotoOfTheDay

final class NetworkTests: XCTestCase {
    
    private var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        cancellables = []
    }
    
    func test_whenPassBadUrlToNetwork_thenCatchError(){
                
        let expectation = self.expectation(description: "Awaiting publisher")
        let endPoint = MockEndpoint.invalidURL
        
        NetworkClient().request(to: endPoint, decodingType: MockModel.self)
            .sink(receiveCompletion: {
                
                switch $0 {
                case .failure(let error):
                    XCTAssertNotNil(error)

                case .finished:
                    XCTAssertTrue(false)
                }
                
                expectation.fulfill()
                
            }, receiveValue: { _ in })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1000)
    }
    
    
    func test_whenGet404ErrorFromNetwork_thenCatchError(){
        
        let expectation = self.expectation(description: "Awaiting publisher")
        let endPoint = MockEndpoint.errorUrl
        
        NetworkClient().request(to: endPoint, decodingType: MockModel.self)
            .sink(receiveCompletion: {
                
                switch $0 {
                case .failure(let error):
                    XCTAssertNotNil(error)
                    
                case .finished:
                    XCTAssertTrue(false)
                }
                
                expectation.fulfill()
                
            }, receiveValue: { _ in })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1000)
    }
    
    func test_whenIncompatibleJsonResponse_thenCatchError(){
        
        let expectation = self.expectation(description: "Awaiting publisher")
        let endPoint = MockEndpoint.successUrl
        
        NetworkClient().request(to: endPoint, decodingType: MockModel.self)
            .sink(receiveCompletion: {
                
                switch $0 {
                case .failure(let error):
                    XCTAssertNotNil(error)
                    
                case .finished:
                    XCTAssertTrue(false)
                }
                
                expectation.fulfill()
                
            }, receiveValue: { _ in })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1000)
    }
    
    func test_whenURLParameters_thenValidURL(){
        
        let endPoint = MockEndpoint.successUrl
        
        guard let url = URL(string: endPoint.url) else {
            return
        }
        
        var request = URLRequest(url: url)
        NetworkRequestBuilder().setupRequest(endPoint, for: &request)
        
        guard let url_ = URLComponents(string: request.url?.absoluteString ?? "") else {
            XCTAssertTrue(false)
            return
        }
        
        XCTAssertEqual(url_.queryItems?.count, 3)
    }
    
}
