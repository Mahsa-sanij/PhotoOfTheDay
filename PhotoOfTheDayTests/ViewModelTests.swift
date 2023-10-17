//
//  ViewModelTests.swift
//  PhotoOfTheDayTests
//
//  Created by Mahsa Sanij on 10/16/23.
//

import XCTest
import Combine
@testable import PhotoOfTheDay

final class ViewModelTests: XCTestCase {
    
    private var cancelables = Set<AnyCancellable>()

    func test_whenGetNasaPlanatoryCalled_thenIsLoadingTrue(){
        
        let networkClient = NetworkClient()
        let diskClient = ImageDiskClient()
        
        let nasaDataProvider = NasaDataProvider(networkClient: networkClient, diskClient: diskClient)
        let viewModel = ViewModel(dataProvider: nasaDataProvider)
        viewModel.getNasaPlanatory()
            
        XCTAssertTrue(viewModel.isLoading)
    }
    
    func test_whenGetNasaPlanatoryDone_thenIsLoadingFalse(){
        
        let networkClient = NetworkClient()
        let diskClient = ImageDiskClient()
        
        let nasaDataProvider = NasaDataProvider(networkClient: networkClient, diskClient: diskClient)
        let viewModel = ViewModel(dataProvider: nasaDataProvider)
        viewModel.getNasaPlanatory()
            
        let expect = expectation(description: "results")

        viewModel.$isLoading
            .dropFirst()
            .removeDuplicates()
            .sink { value in
                XCTAssertFalse(value)
                expect.fulfill()
            }
            .store(in: &self.cancelables)
        
        waitForExpectations(timeout: 3000)
    }
    
    func test_whenGetNasaPlanatoryErrorOccurs_thenErrorMessageNotNil(){
        
        let mockDataProvider = MockDataProvider()
        let viewModel = ViewModel(dataProvider: mockDataProvider)
        viewModel.getNasaPlanatory()
            
        let expectation = expectation(description: "result")

        viewModel.$errorMessage
            .removeDuplicates()
            .sink { value in
                XCTAssertEqual(value ?? "", NetworkError.urlInvalid.description)
                expectation.fulfill()
            }
            .store(in: &self.cancelables)
        
        waitForExpectations(timeout: 3000)
        
    }

}
