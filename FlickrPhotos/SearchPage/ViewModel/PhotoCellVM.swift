//
//  PhotoCellVM.swift
//  FlickrPhotos
//
//  Created by MGLearniOS on 03/05/22.
//

import Foundation

class PhotoCellVM : NSObject {
    init(photo:Photo) {
        self.photo = photo
    }
    
    var reloadCell : (()->Void)?
    var photo : Photo {
        didSet{
            reloadCell?()
        }
    }
}
