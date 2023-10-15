//
//  DiskManagerProtocol.swift
//  PhotoOfTheDay
//
//  Created by Mahsa Sanij on 10/14/23.
//

import Foundation

protocol DiskProtocol {
    
    func checkIfDataExists(in filename: String) -> Bool
    
    func saveDataToDisk(data: Data, to filename: String) throws
    
    func readDataFromDisk(in filename: String) throws -> Data?
    
}
