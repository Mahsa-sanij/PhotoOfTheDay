//
//  ColorReference.swift
//  PhotoOfTheDay
//
//  Created by Mahsa Sanij on 10/15/23.
//

import Foundation
import SwiftUI

enum ColorReference: String {
    
    case dakBlue    = "dark_blue"
    case lightBlue  = "light_blue"
    case orange     = "orange"
    case primary    = "primary"
    case white      = "white"
    case red        =  "red"
}

extension ColorReference {
    
    var color: Color {
        return Color(self.rawValue)
    }
    
    static func color(hex: String) -> Color {
        
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        return Color(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

