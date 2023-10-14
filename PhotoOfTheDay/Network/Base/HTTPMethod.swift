//
//  HTTPMethod.swift
//  PhotoOfTheDay
//
//  Created by Mahsa Sanij on 10/14/23.
//

import Foundation

enum HTTPMethod: String {
    
    case get
    case post
    
    
    public var name: String {
        return rawValue.uppercased()
    }
}
