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
    
    let dataProvider: DataProvider
    private var cancellables = Set<AnyCancellable>()
    
    private var response: NasaResult?
    @Published var title: String?
    @Published var thumbnailImage: UIImage?
    @Published var originalImage: UIImage?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var showFullScreen: Bool = false

    init(dataProvider: DataProvider) {
        
        self.dataProvider = dataProvider
    }
    
    func getNasaPlanatory(){
        
        self.isLoading = true
        
        dataProvider.getApiResponse()
            .sink { result in
                
                switch result {
                    
                case .finished:
                    self.loadImage()
                    
                case .failure(let error):
                    self.isLoading = false
                    self.errorMessage = error.description
                }
                
            } receiveValue: { data in
                self.response = data
                
                self.title = self.response?.title
                if self.response?.media_type == .video {
                    self.response?.url = self.response?.thumbnail_url
                }
            }
            .store(in: &cancellables)
        
    }
    
    func loadImage() {
        
        guard let date = response?.date else {
            isLoading = false
            return
        }
        
        dataProvider.fetchImage(for: date, from: response?.url ?? "")
            .sink { result in
                
                self.isLoading = false
                
            } receiveValue: { isOnDisk in
                
                if isOnDisk {
                    
                    self.getThumbnailImageFromDisk(for: date)
                }
            }
            .store(in: &cancellables)
    }
    
    func getThumbnailImageFromDisk(for date: String) {
        
        self.dataProvider.getThumbnailImage(for: date)
            .sink { result in
                
                self.isLoading = false
                switch result {
                    
                case .finished:
                    break
                    
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
                
            } receiveValue: { image in
                self.thumbnailImage = image
            }
            .store(in: &self.cancellables)
    }
    
    func getOriginalImageFromDisk() {
        
        guard let date = self.response?.date else { return }
        
        self.dataProvider.getOriginalImage(for: date)
            .sink { _ in
                
            } receiveValue: { image in
                self.originalImage = image
            }
            .store(in: &self.cancellables)
    }
}
