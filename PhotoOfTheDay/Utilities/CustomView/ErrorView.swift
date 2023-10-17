//
//  ErrorView.swift
//  PhotoOfTheDay
//
//  Created by Mahsa Sanij on 10/16/23.
//

import SwiftUI

struct ErrorView: View {
    
    let message: String
    let retryAction: () -> Void
    
    var body: some View {
        
        VStack(spacing: 16) {
            
            Text(message)
            
            Button(TextReferences.retry, systemImage: "arrow.circlepath", action: retryAction)
        }
        .padding(.horizontal, 32)

    }
}

