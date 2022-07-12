//
//  Photo.swift
//  FlickrPhotos
//
//  Created by MGLearniOS on 03/05/22.
//

import Foundation

typealias Photos = [Photo]

struct Photo: Decodable{
    let id:String
    let image:String
    let title:String
    let desc:String?
    
    enum CodingKeys:String,CodingKey{
        case id,image,title
        case desc = "description"
    }
}

struct PhotoResponse:Decodable{
    let page : String
    let pages : String
    let perpage : String
    let total : String
    let photo : Photos
    enum CodingKeys:String,CodingKey{
        case page,pages,perpage,total,photo
    }
}

struct PhotosResponse:Decodable{
    let photos : PhotoResponse
    enum CodingKeys:String,CodingKey{
        case photos
    }
}
