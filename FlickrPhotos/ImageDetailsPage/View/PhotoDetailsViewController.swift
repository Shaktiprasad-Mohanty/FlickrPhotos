//
//  PhotoDetailsViewController.swift
//  FlickrPhotos
//
//  Created by MGLearniOS on 03/05/22.
//

import UIKit
import Kingfisher

class PhotoDetailsViewController: UIViewController {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblDesc: UILabel!
    
    class var id:String{return String(describing:self)}
    private var cellVM : PhotoCellVM!
    
    func setUp(cellVM : PhotoCellVM){
        self.cellVM = cellVM
        cellVM.reloadCell = {[weak self] in
            self?.lblTitle.text = self?.cellVM.photo.title
            self?.lblDesc.text = self?.cellVM.photo.desc
            if let url = URL(string:  self?.cellVM.photo.image ?? ""){
                self?.imgView.kf.setImage(with: url)
            } else {
                self?.imgView.image = nil
            }
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
