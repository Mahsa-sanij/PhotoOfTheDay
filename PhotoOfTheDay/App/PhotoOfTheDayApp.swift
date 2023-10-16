//
//  PhotoOfTheDayApp.swift
//  PhotoOfTheDay
//
//  Created by Mahsa Sanij on 10/14/23.
//

import SwiftUI

@main
struct PhotoOfTheDayApp: App {
    
    let networkClient = NetworkClient()
    let diskClient = ImageDiskClient()
    
    @ObservedObject var viewModel: ViewModel
    
    init() {
        let dataProvider = NasaDataProvider(networkClient: networkClient, diskClient: diskClient)
        self.viewModel = .init(dataProvider: dataProvider)
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(self.viewModel)
        }
    }
}
