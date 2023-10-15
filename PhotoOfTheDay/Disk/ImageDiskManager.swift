//
//  DiskManager.swift
//  PhotoOfTheDay
//
//  Created by Mahsa Sanij on 10/14/23.
//

import Foundation
import UIKit

struct ImageDiskClient: DiskProtocol {
    
    func getURL(for filename: String) -> URL? {
        
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .allDomainsMask).first else { return nil }
        
        let fileURL = cachesDirectory.appendingPathComponent(filename)
        return fileURL
    }
    
    func checkIfDataExists(in filename: String) -> Bool {
        
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .allDomainsMask).first else { return false }
        
        let fileURL = cachesDirectory.appendingPathComponent(filename)
        return FileManager.default.fileExists(atPath: fileURL.path)

    }
    
    func saveDataToDisk(data: Data, to filename: String) throws {
        
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .allDomainsMask).first else { return }
        
        let fileURL = cachesDirectory.appendingPathComponent(filename)
        guard let image = UIImage.init(data: data) else { return }
        guard let data = image.jpegData(compressionQuality: 1) else { return }
        
        try data.write(to: fileURL)

    }
    
    func readDataFromDisk(in filename: String) throws -> Data? {
        
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .allDomainsMask).first else { return nil }
        
        let fileURL = cachesDirectory.appendingPathComponent(filename)
        return try Data(contentsOf: fileURL)

    }
    
}
