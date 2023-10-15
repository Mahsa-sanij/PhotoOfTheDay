//
//  ViewModel.swift
//  PhotoOfTheDay
//
//  Created by Mahsa Sanij on 10/14/23.
//

import Foundation
import Combine
import UIKit

class ViewModel: ObservableObject {
    
    let dataProvider : NasaDataProvider
    private var cancellables = Set<AnyCancellable>()
    
    @Published var response : NasaResult?
    @Published var thumbnailImage : UIImage?
    
    init(dataProvider: NasaDataProvider) {
        
        self.dataProvider = dataProvider
    }
    
    func getApiResponse(){
        
        dataProvider.getApiResponse()
            .sink { result in
                
                //TODO:
                switch result {
                    
                case .finished:
                    self.loadImage()
                    
                case .failure(let error):
                    print(error)
                }
                
            } receiveValue: { data in
                self.response = data
            }
            .store(in: &cancellables)
        
    }
    
    func loadImage() {
        
        guard let date = response?.date else {
            return
        }
        
        dataProvider.fetchImage(for: date, from: response?.url ?? "")
            .sink { error in
                print(error)
            } receiveValue: { isOnDisk in
                
                if isOnDisk {
                    self.dataProvider.getThumbnailImage(for: date)
                        .sink { error in
                            print(error)
                        } receiveValue: { image in
                            self.thumbnailImage = image
                        }
                        .store(in: &self.cancellables)

                }
            }
            .store(in: &cancellables)

        
        
    }
}
