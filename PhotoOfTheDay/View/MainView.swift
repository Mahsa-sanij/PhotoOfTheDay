//
//  ContentView.swift
//  PhotoOfTheDay
//
//  Created by Mahsa Sanij on 10/14/23.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    let networkClient = NetworkClient()
    let diskClient = ImageDiskClient()
    @ObservedObject var viewModel : ViewModel
    
    init() {
        let dataProvider = NasaDataProvider(networkClient: networkClient, diskClient: diskClient)
        viewModel = ViewModel(dataProvider: dataProvider)
    }
    
    var body: some View {
        
        VStack(spacing: 8) {
            
            Image(uiImage: viewModel.thumbnailImage ?? UIImage(systemName: "globe")!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: UIScreen.main.bounds.height/2)
                .cornerRadius(8)
            
            
            Text(viewModel.response?.title ?? "")
                .bold()
            
            
            Text(viewModel.response?.explanation ?? "")
            
        }
        .padding()
        .onAppear {
            viewModel.getApiResponse()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
