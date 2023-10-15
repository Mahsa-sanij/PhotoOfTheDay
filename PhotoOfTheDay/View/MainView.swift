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
        
        NavigationView {
            
            VStack(spacing: 12) {
                
                ZStack(alignment: .trailing) {
                    
                        Image(uiImage: viewModel.thumbnailImage ?? UIImage(systemName: "globe")!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(8)
                        
                        
                    VStack {
                        Spacer()
                        
                        ImageReference.fullscreen.image
                            .resizable()
                            .frame(width: 32, height: 32)
                            .padding(.all, 24)
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: UIScreen.main.bounds.height/2)

                
                
                Text(viewModel.response?.title ?? "")
                    .bold()
                
                
                Text(viewModel.response?.explanation ?? "")
                    .lineLimit(4)
                
            }
            .padding()
            .onAppear {
                viewModel.getApiResponse()
            }
            .navigationTitle("Picture of the day")
            .navigationBarTitleDisplayMode(.large)
            
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
