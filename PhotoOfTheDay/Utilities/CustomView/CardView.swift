//
//  CardView.swift
//  PhotoOfTheDay
//
//  Created by Mahsa Sanij on 10/16/23.
//

import SwiftUI

struct CardView: View {
    
    var radius : CGFloat = 8
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: radius)
            .foregroundColor(Color.white)
            .shadow(color: ColorReference.color(hex: "#e7e7e7"), radius: 2, x: 0, y: 0)
    }
}

#Preview {
    CardView()
}
