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
    @Namespace var animation
    
    private let animationDuration: CGFloat = 0.35
    
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                ZStack {
                    
                    if viewModel.isLoading {
                        
                        LoadingView()
                        
                    }
                    else if viewModel.errorMessage != nil {
                        
                        ErrorView(message: viewModel.errorMessage!)
                        
                    }
                    else if viewModel.title != nil && viewModel.thumbnailImage != nil {
                        
                        ContentView()
                        
                    }
                    
                    if viewModel.showFullScreen {
                        
                        FullScreenView(image: viewModel.originalImage ?? viewModel.thumbnailImage!)
                            .onTapGesture {
                                withAnimation {
                                    self.viewModel.showFullScreen.toggle()
                                }
                            }
                            .transition(.scale)

                    }
                    
                }
                .animation(.easeInOut, value: animationDuration)
                .onAppear {
                    viewModel.getNasaPlanatory()
                }
                
            }
            .navigationTitle(TextReferences.title)
            .navigationBarTitleDisplayMode(.large)
            
        }
    }
}


