//
//  NetworkError.swift
//  PhotoOfTheDay
//
//  Created by Mahsa Sanij on 10/14/23.
//

import Foundation

enum NetworkError: Error {
    
    case requestFailure
    case invalidURL
    case jsonConversionFailure
    case invalidData
    
    var description: String {
        switch self {
            
        case .requestFailure: return TextReferences.errorRequestFailure
        case .invalidURL: return TextReferences.errorUrlInvalid
        case .invalidData: return TextReferences.errorDataInvalid
        case .jsonConversionFailure: return TextReferences.errorJsonConversionFailure
        }
    }
}
