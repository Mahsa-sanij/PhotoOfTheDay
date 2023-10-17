//
//  ErrorView.swift
//  PhotoOfTheDay
//
//  Created by Mahsa Sanij on 10/16/23.
//

import SwiftUI

struct ErrorView: View {
    
    let message: String
    
    var body: some View {
        
        Text(message)
            .padding(.horizontal, 32)
    }
}

