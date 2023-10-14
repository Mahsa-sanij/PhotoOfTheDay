//
//  NetworkClient.swift
//  PhotoOfTheDay
//
//  Created by Mahsa Sanij on 10/14/23.
//

import Foundation
import Combine

struct NetworkClient: NetworkProtocol {
    
    private let urlSession = URLSession(configuration: .default)
    
    func request<T>(to endPoint: EndPoint, decodingType: T.Type) -> AnyPublisher<T, Error> where T : Decodable {
        
        guard let url = URL(string: endPoint.url) else {
            return Fail(error: NetworkError.urlInvalid).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        setupRequest(endPoint, for: &request)
        
        return urlSession.dataTaskPublisher(for: request)
            .tryMap { element -> T in
                
                guard let httpResponse = element.response as? HTTPURLResponse,
                      (httpResponse.statusCode == 200 || httpResponse.statusCode == 202) else {
                    throw NetworkError.requestFailure
                }
                
                do {
                    let response = try JSONDecoder().decode(T.self, from: element.data)
                    return response
                }
                catch {
                    throw NetworkError.jsonConversionFailure
                }
            }
            .retry(1)
            .eraseToAnyPublisher()
    }
    
    private func setupRequest(_ endpoint: EndPoint, for request: inout URLRequest) {
        
        request.httpMethod = endpoint.httpMethod.name
        endpoint.headers?.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        //Configure URL parameters
        if let urlParameters = endpoint.urlParameters,
           let url = request.url,
           var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) {
            urlComponents.queryItems = urlParameters.map { URLQueryItem(name: $0.key, value: $0.value)
            }
            
            request.url = urlComponents.url
        }
        
        
        //Configure body parameters for POST requests
        if endpoint.httpMethod == .post {
            
            if let bodyParameters = endpoint.body,
               let payload = try? JSONSerialization.data(withJSONObject: bodyParameters, options: []) {
                request.httpBody = payload
            }
            
        }
        
    }
    
}
