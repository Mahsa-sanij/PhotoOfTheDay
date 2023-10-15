//
//  ImageDataProvider.swift
//  PhotoOfTheDay
//
//  Created by Mahsa Sanij on 10/14/23.
//

import Foundation
import Combine
import UIKit

struct NasaDataProvider {
    
    private let networkClient: NetworkClient
    private let diskClient: ImageDiskClient
    
    private var cancellables = Set<AnyCancellable>()
    private var downsampler = ImageDownSampler(thumbnailSize: .init(width: ImageDownSampler.halfScreenHeight, height: ImageDownSampler.halfScreenHeight))
    
    init(networkClient: NetworkClient, diskClient: ImageDiskClient) {
        self.networkClient = networkClient
        self.diskClient = diskClient
    }
    
    func getApiResponse() -> AnyPublisher<NasaResult, Error> {
        
        return networkClient.request(to: NasaEndPoint.planetary, decodingType: NasaResult.self)
        
    }
    
    func fetchImage(for date: String, from url: String) -> AnyPublisher<Bool, Error> {
        
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
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
        
        return Just(true)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        
    }
    
    func getThumbnailImage(for date: String) -> AnyPublisher<UIImage, Error> {
        
        let filename = date
        
        if diskClient.checkIfDataExists(in: filename) {
            
            if let uri = diskClient.getURL(for: filename), let image = downsampler.downsample(in: uri) {
                
                return Just(image)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
            
        }
        
        return Fail(error: NetworkError.invalidData).eraseToAnyPublisher()
        
    }
    
    func getOriginalImage(for date: String) -> AnyPublisher<UIImage, Error> {
        
        let filename = date
        
        if diskClient.checkIfDataExists(in: filename) {
            
            do {
                if let imageData = try diskClient.readDataFromDisk(in: filename), let image = UIImage(data: imageData) {
                    
                    return Just(image)
                        .setFailureType(to: Error.self)
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
