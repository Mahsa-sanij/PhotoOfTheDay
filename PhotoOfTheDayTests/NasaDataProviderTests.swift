//
//  ImageDataProviderTests.swift
//  PhotoOfTheDayTests
//
//  Created by Mahsa Sanij on 10/16/23.
//

import XCTest
import Combine
@testable import PhotoOfTheDay

final class NasaDataProviderTests: XCTestCase {
    
    private var cancellables = Set<AnyCancellable>()
    
    private let mockDate = "2023-10-22"
    private let mockImageURL = "https://statusneo.com/wp-content/uploads/2023/02/MicrosoftTeams-image551ad57e01403f080a9df51975ac40b6efba82553c323a742b42b1c71c1e45f1.jpg"
    
    func test_whenFetchImageCalledAndImageNotOnDisk_thenDoesNotThrowError() {
        
        let networkClient = PhotoOfTheDay.NetworkClient()
        let diskClient = PhotoOfTheDay.ImageDiskClient()
        
        let dataProvider = NasaDataProvider(networkClient: networkClient, diskClient: diskClient)
        let expectation = self.expectation(description: "Awaiting publisher")
        
        dataProvider.fetchImage(for: mockDate, from: mockImageURL)
            .sink { result in
                
                expectation.fulfill()
                
            } receiveValue: { image in
                
                XCTAssertNotNil(image)
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 3000)
    }
    
    func test_whenGetThumbnailImageCalled_thenGetImageWithScreenHalfHeight(){
        
        let networkClient = PhotoOfTheDay.NetworkClient()
        let diskClient = PhotoOfTheDay.ImageDiskClient()
        
        let dataProvider = NasaDataProvider(networkClient: networkClient, diskClient: diskClient)
        
        let expectation = self.expectation(description: "Awaiting publisher")
        
        dataProvider.fetchImage(for: mockDate, from: mockImageURL)
            .sink { result in
                
            } receiveValue: { image in
                
                dataProvider.getThumbnailImage(for: self.mockDate)
                    .sink { result in
                        
                        expectation.fulfill()
                        
                    } receiveValue: { image in
                        
                        XCTAssertNotNil(image)
                        XCTAssertEqual(image.size.height, UIScreen.height/2)
                    }
                    .store(in: &self.cancellables)
                
            }
            .store(in: &cancellables)
        
        
        
        waitForExpectations(timeout: 3000)
    }
    
}
