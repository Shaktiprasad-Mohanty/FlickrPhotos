//
//  PhotosTableViewCell.swift
//  FlickrPhotos
//
//  Created by MGLearniOS on 03/05/22.
//

import UIKit
import Kingfisher

class PhotosTableViewCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    class var id : String { return  String(describing: self)}
    
    private var cellVM : PhotoCellVM!
    
    func setUp(cellVM : PhotoCellVM){
        self.cellVM = cellVM
        cellVM.reloadCell = {[weak self] in
            self?.lblTitle.text = self?.cellVM.photo.title
            if let url = URL(string:  self?.cellVM.photo.image ?? ""){
                self?.imgView.kf.setImage(with: url)
            } else {
                self?.imgView.image = nil
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        self.lblTitle.text = ""
        self.imgView.image = nil
    }
    
}
