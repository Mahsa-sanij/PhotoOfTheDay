//
//  LoadingView.swift
//  PhotoOfTheDay
//
//  Created by Mahsa Sanij on 10/16/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        
        ProgressView()
            .progressViewStyle(.circular)
    }
}

#Preview {
    LoadingView()
}
