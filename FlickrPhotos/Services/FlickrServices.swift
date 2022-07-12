//
//  FlickrServices.swift
//  FlickrPhotos
//
//  Created by MGLearniOS on 03/05/22.
//

import Foundation

protocol FlickrServiceProtocol{
    func serachImages(searchStr:String,completion: @escaping(_ photo:PhotoResponse?,_ errorMsg : String?)->Void)
}

class  FlickrService:FlickrServiceProtocol{
    private let apiService:APISeviceProtocol
    init(apiService:APISeviceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func serachImages(searchStr: String, completion: @escaping (PhotoResponse?, String?) -> Void) {
        apiService.callAPI(param: ["text":searchStr,"api_key":"b5ae04177196c9f42b8fa69daebbbf8c"], urlStr: "flickr.photos.search.html") { data, isSuccess in
            if let data = data {
                do {
                    let photos = try JSONDecoder().decode(PhotosResponse.self, from: data)
                    
                    DispatchQueue.main.async {
                        completion(photos.photos,nil)
                    }
                } catch let e {
                    DispatchQueue.main.async {
                        completion(nil,e.localizedDescription)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil,"Unable to get data from server!")
                }
            }
        }
    }
}


