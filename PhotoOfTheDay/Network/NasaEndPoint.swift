//
//  NasaEndPoint.swift
//  PhotoOfTheDay
//
//  Created by Mahsa Sanij on 10/15/23.
//

import Foundation

enum NasaEndPoint: EndPoint {
    
    case planetary
    case neo
    
    var baseUrl: String {
        return "https://api.nasa.gov/"
    }

    var url: String {
        
        switch self {
        case .neo:
            return baseUrl + "planetary/neo"
            
        case .planetary:
            return baseUrl + "planetary/apod"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var urlParameters: [String : String]? {
        return ["api_key": NasaEndPoint.apiKey]
    }
    
    var body: [String : Any]? {
        return nil
    }
    
}

extension NasaEndPoint {
    
    static var apiKey: String {
        return "NNKOjkoul8n1CH18TWA9gwngW1s1SmjESPjNoUFo"
    }
}
