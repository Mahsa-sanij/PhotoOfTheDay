//
//  ImageReference.swift
//  PhotoOfTheDay
//
//  Created by Mahsa Sanij on 10/15/23.
//

import Foundation
import SwiftUI

enum ImageReference: String {

    case placeholder  = "placeholder"
    case fullscreen  = "ic_fullscreen"
}

extension ImageReference {
    var image: Image {
        return Image(self.rawValue)
    }
}
