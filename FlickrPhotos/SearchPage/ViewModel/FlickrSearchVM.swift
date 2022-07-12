//
//  FlickrSearchVM.swift
//  FlickrPhotos
//
//  Created by MGLearniOS on 03/05/22.
//

import Foundation

class FlickrSearchVM : NSObject{
    private let service : FlickrService
    var reloadTableview : (()->Void)?
    var searchString = ""
    
    var photoResponse : PhotoResponse?{
        didSet{
            reloadTableview?()
        }
    }
    
    init(service : FlickrService = FlickrService()) {
        self.service = service
    }
    
    func fetchData(){
        service.serachImages(searchStr: searchString) { response, message in
            if let response = response {
                self.photoResponse = response
            } else {
                print("EROOR:---------------\(message ?? "")-------------------")
            }
        }
    }
    
    
}
