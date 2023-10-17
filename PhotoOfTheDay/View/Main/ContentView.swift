//
//  ContentView.swift
//  PhotoOfTheDay
//
//  Created by Mahsa Sanij on 10/16/23.
//

import SwiftUI

struct ContentView<Content: View>: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    private var destinationView: () -> Content
    
    init(@ViewBuilder destinationView: @escaping () -> Content) {
        
        self.destinationView = destinationView
    }
    
    var body: some View {
        
        ZStack {
            
            ZStack(alignment: .center) {
                
                VStack(spacing: 12) {
                    
                    Spacer()
                    
                    if !viewModel.showFullScreen {
                        
                        ThumbnailImageView()
                            .frame(height: UIScreen.height / 2)
                        
                    }
                    
                    Spacer()
                    
                }
                
                VStack {
                    
                    Spacer()
                    
                    
                    Text(self.viewModel.title ?? "")
                        .font(.title)
                        .bold()
                        .lineLimit(3)
                        .minimumScaleFactor(.leastNonzeroMagnitude)
                        .multilineTextAlignment(.center)
                        .opacity(self.viewModel.showFullScreen ? 0 : 1)
                        .frame(height: UIScreen.height * 0.12)
                }
                
            }
            .padding()
            
            
            if viewModel.showFullScreen {
                
                destinationView()
                    .onTapGesture {
                        withAnimation {
                            self.viewModel.showFullScreen.toggle()
                        }
                    }
                    .transition(.scale)
                
            }
        }
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

