//
//  RequestBuilder.swift
//  PhotoOfTheDay
//
//  Created by Mahsa Sanij on 10/14/23.
//

import Foundation

struct NetworkRequestBuilder {
    
    func setupRequest(_ endpoint: EndPoint, for request: inout URLRequest) {
        
        request.httpMethod = endpoint.httpMethod.name
        configureHeaders(endpoint.headers, for: &request)
        configureUrlParameters(endpoint.urlParameters, for: &request)
        
        if endpoint.httpMethod == .post {
            configureBodyParameters(endpoint.body, for: &request)
        }
        
    }
    
    
    func configureHeaders(_ headers: [String: String]?, for request: inout URLRequest) {
        
        headers?.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
    }
    
    //Configure body parameters for POST requests
    func configureBodyParameters(_ parameters: [String: Any]?, for request: inout URLRequest) {
        
        if let bodyParameters = parameters,
           let payload = try? JSONSerialization.data(withJSONObject: bodyParameters, options: []) {
            request.httpBody = payload
        }
    }
    
    //Configure URL parameters
    func configureUrlParameters(_ parameters: [String: String]?, for request: inout URLRequest) {
        
        if let urlParameters = parameters,
           let url = request.url,
           var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) {
            urlComponents.queryItems = urlParameters.map { URLQueryItem(name: $0.key, value: $0.value)
            }
            
            request.url = urlComponents.url
        }
        
    }
    
    
}
