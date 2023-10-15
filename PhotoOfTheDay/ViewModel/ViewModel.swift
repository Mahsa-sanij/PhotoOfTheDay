//
//  ViewModel.swift
//  PhotoOfTheDay
//
//  Created by Mahsa Sanij on 10/14/23.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    
    var cancellables = Set<AnyCancellable>()

    func getImage(){
        
        ImageDataProvider().getThumbnailImage(for: "2023-10-14", from: "https://apod.nasa.gov/apod/image/2310/Vincenzo_Mirabella_20210529_134459_1024px.jpg")
            .sink { error in
                print(error)
            } receiveValue: { image in
                
                print("here")
            }
            .store(in: &cancellables)
        
    }
}
