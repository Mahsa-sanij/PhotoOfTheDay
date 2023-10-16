//
//  ContentView.swift
//  PhotoOfTheDay
//
//  Created by Mahsa Sanij on 10/14/23.
//

import SwiftUI
import Combine

struct MainView: View {
    
    @EnvironmentObject var viewModel : ViewModel
    
    private let animationDuration: CGFloat = 0.35
    private let titlePadding: CGFloat = 32
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                ZStack {
                    
                    if viewModel.isLoading {
                        
                        ProgressView()
                            .progressViewStyle(.circular)
                    }
                    else if viewModel.errorMessage != nil {
                        
                        Text(viewModel.errorMessage ?? "")
                            .padding(.horizontal, 32)
                        
                    }
                    else if viewModel.title != nil && viewModel.thumbnailImage != nil {
                        
                        ZStack(alignment: .center) {
                            
                            VStack(spacing: 12) {
                                
                                Spacer()
                                
                                ThumbnailImageView()
                                    .frame(height: UIScreen.height / 2)
                                
                                Spacer()
                                
                            }
                            
                            Text(self.viewModel.title ?? "")
                                .font(.title)
                                .bold()
                                .multilineTextAlignment(.center)
                                .fixedSize(horizontal: false, vertical: true)
                                .opacity(self.viewModel.showFullScreen ? 0 : 1)
                                .offset(y: UIScreen.height / 4 + titlePadding)
                            
                        }
                        .padding()
                        
                    }
                    
                    if viewModel.showFullScreen {
                        
                        //TODO:
                        FullScreenView(image: viewModel.thumbnailImage!)
                            .onTapGesture {
                                self.viewModel.showFullScreen.toggle()
                            }
                    }
                    
                }
                .animation(.easeInOut, value: animationDuration)
                .onAppear {
                    viewModel.getApiResponse()
                }
                
            }
            .navigationTitle(TextReferences.title)
            .navigationBarTitleDisplayMode(.large)
            
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

