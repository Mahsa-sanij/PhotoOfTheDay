//
//  NetworkProtocol.swift
//  PhotoOfTheDay
//
//  Created by Mahsa Sanij on 10/14/23.
//

import Foundation
import Combine

protocol NetworkManager {
    
    func request<T: Decodable>(to endPoint: EndPoint, decodingType: T.Type) -> AnyPublisher<T, NetworkError>
    
    func download(from url: String, headers: [String: String]?, urlParameters: [String: String]?) -> AnyPublisher<Data, NetworkError>

}
