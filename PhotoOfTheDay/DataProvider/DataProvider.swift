//
//  DataProvider.swift
//  PhotoOfTheDay
//
//  Created by Mahsa Sanij on 10/16/23.
//

import Combine
import UIKit

protocol DataProvider {
    
    func getApiResponse() -> AnyPublisher<NasaResult, NetworkError>
    
    func fetchImage(for date: String, from url: String) -> AnyPublisher<Bool, NetworkError>
    
    func getThumbnailImage(for date: String) -> AnyPublisher<UIImage, NetworkError>
    
    func getOriginalImage(for date: String) -> AnyPublisher<UIImage, NetworkError>
    
}
