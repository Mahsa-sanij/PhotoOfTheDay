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
    
    private let retryCount = 1
    
    func request<T>(to endPoint: EndPoint, decodingType: T.Type) -> AnyPublisher<T, Error> where T : Decodable {
        
        guard let url = URL(string: endPoint.url) else {
            return Fail(error: NetworkError.urlInvalid).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        NetworkRequestBuilder().setupRequest(endPoint, for: &request)
        
        return urlSession.dataTaskPublisher(for: request)
            .tryMap { result -> T in
                
                guard checkResponseCodeIsValid(for: result.response) else {
                    throw NetworkError.requestFailure
                }
                
                do {
                    let response = try JSONDecoder().decode(T.self, from: result.data)
                    return response
                }
                catch {
                    throw NetworkError.jsonConversionFailure
                }
            }
            .retry(retryCount)
            .eraseToAnyPublisher()
    }
    
    
    func download(from url: String, headers: [String: String]? = nil, urlParameters: [String: String]? = nil) -> AnyPublisher<Data, Error> {
        
        guard let url_ = URL(string: url) else {
            return Fail(error: NetworkError.urlInvalid).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url_)
        let requestBuilder = NetworkRequestBuilder()
        
        requestBuilder.configureHeaders(headers, for: &request)
        requestBuilder.configureUrlParameters(urlParameters, for: &request)
        
        return urlSession.dataTaskPublisher(for: request)
            .tryMap { result -> Data in
                
                guard checkResponseCodeIsValid(for: result.response)  else {
                    throw NetworkError.requestFailure
                }
                
                return result.data
            }
            .retry(retryCount)
            .eraseToAnyPublisher()
    }
    
    
    private func checkResponseCodeIsValid(for response: URLResponse) -> Bool {
        
        if let httpResponse = response as? HTTPURLResponse
        {
            return (httpResponse.statusCode == 200 || httpResponse.statusCode == 202)
        }
        
        return false
        
    }
    
}
