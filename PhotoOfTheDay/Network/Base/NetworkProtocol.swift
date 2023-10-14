//
//  NetworkProtocol.swift
//  PhotoOfTheDay
//
//  Created by Mahsa Sanij on 10/14/23.
//

import Combine

protocol NetworkProtocol {
    
    func request<T: Decodable>(to endPoint: EndPoint, decodingType: T.Type) throws -> AnyPublisher<T, Error>

}
