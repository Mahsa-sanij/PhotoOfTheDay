//
//  MockEndpoint.swift
//  PhotoOfTheDayTests
//
//  Created by Mahsa Sanij on 10/14/23.
//

@testable import PhotoOfTheDay

enum MockEndpoint: PhotoOfTheDay.EndPoint {
    
    case successUrl
    case errorUrl
    case invalidURL
    
    var baseUrl: String {
        return ""
    }
    
    var url: String {
        
        switch self {
          
        case .successUrl:
            return "https://api.nasa.gov/planetary/apod"
            
        case .errorUrl:
            return "https://api.nasa.gov/planetary/apo"
            
        case .invalidURL:
            return "۱۳۴/#user@"
            
        }
    }
    
    var httpMethod: PhotoOfTheDay.HTTPMethod {
        return .get
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var urlParameters: [String : String]? {
        
        switch self {
            
        case .successUrl:
            return [ "api_key": "NNKOjkoul8n1CH18TWA9gwngW1s1SmjESPjNoUFo",
                     "startDate": "2023-10-12",
                    "endDate": "2023-10-22"]
            
        default:
            return nil
        }
    }
    
    var body: [String : Any]? {
        return nil
    }
    
}
