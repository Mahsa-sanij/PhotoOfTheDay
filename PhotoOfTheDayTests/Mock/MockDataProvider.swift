//
//  MockDataProvider.swift
//  PhotoOfTheDayTests
//
//  Created by Mahsa Sanij on 10/16/23.
//

import Combine
@testable import PhotoOfTheDay
import UIKit

struct MockDataProvider: DataProvider{
    
    func getApiResponse() -> AnyPublisher<NasaResult, NetworkError> {
        
        return Fail(error: NetworkError.urlInvalid).eraseToAnyPublisher()
    }
    
    func fetchImage(for date: String, from url: String) -> AnyPublisher<Bool, NetworkError> {
        return Fail(error: NetworkError.urlInvalid).eraseToAnyPublisher()
    }
    
    func getThumbnailImage(for date: String) -> AnyPublisher<UIImage, NetworkError> {
        return Fail(error: NetworkError.urlInvalid).eraseToAnyPublisher()

    }
    
    func getOriginalImage(for date: String) -> AnyPublisher<UIImage, NetworkError> {
        return Fail(error: NetworkError.urlInvalid).eraseToAnyPublisher()

    }
    
        
}
