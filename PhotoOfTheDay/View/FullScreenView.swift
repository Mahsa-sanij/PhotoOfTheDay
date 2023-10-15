//
//  FullScreenView.swift
//  PhotoOfTheDay
//
//  Created by Mahsa Sanij on 10/15/23.
//

import SwiftUI

struct FullScreenView: View {
    
    let image: UIImage
    
    @State private var currentZoom = 0.0
    @State private var totalZoom = 1.0
    
    var body: some View {
        
        Image(uiImage: image)
            .scaleEffect(currentZoom + totalZoom)
            
        
    }
}
