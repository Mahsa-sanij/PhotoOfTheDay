//
//  NasaPhoto.swift
//  PhotoOfTheDay
//
//  Created by Mahsa Sanij on 10/15/23.
//

import Foundation

enum NasaMediaType: String, Decodable {
    
    case image = "image"
    case video = "video"
}


struct NasaResult: Decodable {
    
    let copyright : String?
    let date : String?
    let explanation : String?
    let hdurl : String?
    let media_type : NasaMediaType?
    let service_version : String?
    let title : String?
    var url : String?
    let thumbnail_url : String?


    enum CodingKeys: String, CodingKey {

        case copyright = "copyright"
        case date = "date"
        case explanation = "explanation"
        case hdurl = "hdurl"
        case media_type = "media_type"
        case service_version = "service_version"
        case title = "title"
        case url = "url"
        case thumbnail_url = "thumbnail_url"

    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        copyright = try values.decodeIfPresent(String.self, forKey: .copyright)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        explanation = try values.decodeIfPresent(String.self, forKey: .explanation)
        hdurl = try values.decodeIfPresent(String.self, forKey: .hdurl)
        media_type = try values.decodeIfPresent(NasaMediaType.self, forKey: .media_type)
        service_version = try values.decodeIfPresent(String.self, forKey: .service_version)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        thumbnail_url = try values.decodeIfPresent(String.self, forKey: .thumbnail_url)
    }
    
}
