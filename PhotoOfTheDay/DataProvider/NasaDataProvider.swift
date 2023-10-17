//
//  ImageDataProvider.swift
//  PhotoOfTheDay
//
//  Created by Mahsa Sanij on 10/14/23.
//

import Foundation
import Combine
import UIKit

struct NasaDataProvider: DataProvider {
    
    private let networkClient: NetworkClient
    private let diskClient: ImageDiskClient
    
    private var cancellables = Set<AnyCancellable>()
    private var downsampler = ImageDownSampler(thumbnailSize: .init(width: UIScreen.height/2 , height: UIScreen.height/2))
    
    init(networkClient: NetworkClient, diskClient: ImageDiskClient) {
        self.networkClient = networkClient
        self.diskClient = diskClient
    }
    
    func getApiResponse() -> AnyPublisher<NasaResult, NetworkError> {
        
        return networkClient.request(to: NasaEndPoint.planetary, decodingType: NasaResult.self)
    }
    
    func fetchImage(for date: String, from url: String) -> AnyPublisher<Bool, NetworkError> {
        
        let filename = date
        if !diskClient.checkIfDataExists(in: filename) {
            
            return networkClient.download(from: url)
                .tryMap { data in
                    
                    do {
                        try diskClient.saveDataToDisk(data: data, to: filename)
                    }
                    catch {
                        throw NetworkError.invalidData
                    }
                    
                    return true
                    
                }
                .mapError({ _ in
                    return NetworkError.requestFailure
                })
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
        
        return Just(true)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
        
    }
    
    func getThumbnailImage(for date: String) -> AnyPublisher<UIImage, NetworkError> {
        
        let filename = date
        
        if diskClient.checkIfDataExists(in: filename) {
            
            if let uri = diskClient.getURL(for: filename), let image = downsampler.downsample(in: uri) {
                
                return Just(image)
                    .setFailureType(to: NetworkError.self)
                    .eraseToAnyPublisher()
            }
            
        }
        
        return Fail(error: NetworkError.invalidData).eraseToAnyPublisher()
        
    }
    
    func getOriginalImage(for date: String) -> AnyPublisher<UIImage, NetworkError> {
        
        let filename = date
        
        if diskClient.checkIfDataExists(in: filename) {
            
            do {
                if let imageData = try diskClient.readDataFromDisk(in: filename), let image = UIImage(data: imageData) {
                    
                    return Just(image)
                        .setFailureType(to: NetworkError.self)
                        .eraseToAnyPublisher()
                }
            }
            catch {
                
                return Fail(error: NetworkError.invalidData)
                    .eraseToAnyPublisher()
            }
        }
        
        return Fail(error: NetworkError.invalidData).eraseToAnyPublisher()
        
    }
    
    
}
