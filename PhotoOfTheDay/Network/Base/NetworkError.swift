//
//  NetworkError.swift
//  PhotoOfTheDay
//
//  Created by Mahsa Sanij on 10/14/23.
//

import Foundation

enum NetworkError: Error {
    
    case requestFailure
    case urlInvalid
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    
    var localizedDescription: String {
        switch self {
            
        case .requestFailure: return "Request Failed"
        case .urlInvalid: return "URL Invalid"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        }
    }
}
