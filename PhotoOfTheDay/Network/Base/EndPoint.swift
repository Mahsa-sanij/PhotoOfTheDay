//
//  EndPoint.swift
//  PhotoOfTheDay
//
//  Created by Mahsa Sanij on 10/14/23.
//

import Foundation

protocol EndPoint {
        
    var baseUrl : String                    { get }
    
    var url: String                         { get }
    var httpMethod: HTTPMethod              { get }
    var headers: [String : String]?         { get }
    var urlParameters: [String : String]?   { get }
    var body: [String : Any]?               { get }

}
