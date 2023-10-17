//
//  ContentView.swift
//  PhotoOfTheDay
//
//  Created by Mahsa Sanij on 10/16/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        
        ZStack(alignment: .center) {
            
            VStack(spacing: 12) {
                
                Spacer()
                
                if !viewModel.showFullScreen {
                    
                    ThumbnailImageView()
                        .frame(height: UIScreen.height / 2)
                        
                }
                
                Spacer()
                
            }
            
            Text(self.viewModel.title ?? "")
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .opacity(self.viewModel.showFullScreen ? 0 : 1)
                .offset(y: UIScreen.height / 4 + 32)
            
        }
        .padding()
    }
}


struct ThumbnailImageView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        
        ZStack(alignment: .trailing) {
            
            Image(uiImage: viewModel.thumbnailImage!)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            
            if !viewModel.showFullScreen {
                
                VStack {
                    
                    Spacer()
                    
                    ImageReference.fullscreen.image
                        .resizable()
                        .onTapGesture {
                            withAnimation(.spring()) {
                                self.viewModel.getOriginalImageFromDisk()
                                self.viewModel.showFullScreen.toggle()
                            }
                        }
                        .padding(.all, 4)
                        .background(CardView(radius: 4))
                        .frame(width: 32, height: 32)
                        .padding(.all, 24)
                    
                }
            }
        }
        
    }
    
}

#Preview {
    ContentView()
}
