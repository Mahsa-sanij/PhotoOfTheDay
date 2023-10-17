//
//  DiskTests.swift
//  PhotoOfTheDayTests
//
//  Created by Mahsa Sanij on 10/14/23.
//

import XCTest
@testable import PhotoOfTheDay

final class DiskTests: XCTestCase {
    
    let diskClient = ImageDiskClient()

    func test_whenDataDoesNotExistOnDisk_thenReturnFalse() {
        
        XCTAssertFalse(diskClient.checkIfDataExists(in: "thumbnail-123.png"))
    }
    
    func test_whenSaveDataToDiskCalled_thenDoesNotThrow() {
        
        if let mockPath = Bundle(for: type(of: self)).url(forResource: "img_trumpet", withExtension: ".png"), let mockData = try? Data(contentsOf: mockPath) {
            
            XCTAssertNoThrow(try diskClient.saveDataToDisk(data: mockData, to: "mock_image"))
        }
    }
    
    func test_whenGetDataFromDiskCalled_thenDataIsNotNil() {
        
        if let mockPath = Bundle(for: type(of: self)).url(forResource: "img_trumpet", withExtension: ".png"), let mockData = try? Data(contentsOf: mockPath) {
            
            try? diskClient.saveDataToDisk(data: mockData, to: "mock_image")
        }
        
        XCTAssertNoThrow(try diskClient.readDataFromDisk(in: "mock_image"))
        XCTAssertNotNil(try diskClient.readDataFromDisk(in: "mock_image"))
    }

}
