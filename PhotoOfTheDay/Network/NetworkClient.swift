//
//  NetworkClient.swift
//  PhotoOfTheDay
//
//  Created by Mahsa Sanij on 10/14/23.
//

import Foundation
import Combine

struct NetworkClient: NetworkManager {
    
    private let networkRequestBuilder = NetworkRequestBuilder()
    
    private let urlSession = URLSession(configuration: .default)
    private let retryCount = 1
    
    func request<T>(to endPoint: EndPoint, decodingType: T.Type) -> AnyPublisher<T, NetworkError> where T : Decodable {
        
        guard let url = URL(string: endPoint.url) else {
            return Fail(error: NetworkError.urlInvalid).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        networkRequestBuilder.setupRequest(endPoint, for: &request)
        
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
            .mapError({ _ in
                return NetworkError.requestFailure
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
    func download(from url: String, headers: [String: String]? = nil, urlParameters: [String: String]? = nil) -> AnyPublisher<Data, NetworkError> {
        
        guard let url_ = URL(string: url) else {
            return Fail(error: NetworkError.urlInvalid).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url_)
        networkRequestBuilder.configureHeaders(headers, for: &request)
        networkRequestBuilder.configureUrlParameters(urlParameters, for: &request)
        
        return urlSession.dataTaskPublisher(for: request)
            .tryMap { result -> Data in
                
                guard checkResponseCodeIsValid(for: result.response)  else {
                    throw NetworkError.requestFailure
                }
                
                return result.data
            }
            .retry(retryCount)
            .mapError({ _ in
                return NetworkError.requestFailure
            })
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
