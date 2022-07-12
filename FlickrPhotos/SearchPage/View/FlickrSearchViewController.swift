//
//  FlickrSearchViewController.swift
//  FlickrPhotos
//
//  Created by MGLearniOS on 03/05/22.
//

import UIKit
import SwiftUI

class FlickrSearchViewController: UIViewController {
    @IBOutlet weak var tblPhotos: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    lazy var viewModel = {
        FlickrSearchVM()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initiateVM()
    }
    func initiateVM(){
        viewModel.reloadTableview = {[weak self] in
            self?.tblPhotos.reloadData()
        }
        viewModel.fetchData()
        
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

extension FlickrSearchViewController : UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        viewModel.searchString = searchBar.text ?? ""
        viewModel.fetchData()
    }
}

extension FlickrSearchViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.photoResponse?.photo.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:PhotosTableViewCell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.id) as? PhotosTableViewCell else {
            fatalError("Please check the cell id")
        }
        cell.setUp(cellVM: PhotoCellVM(photo: viewModel.photoResponse!.photo[indexPath.row]))
        return cell
    }
    
    
}

extension FlickrSearchViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: PhotoDetailsViewController.id) as? PhotoDetailsViewController else {
            fatalError("Please check the view controller id")
        }
        self.navigationController?.pushViewController(vc, animated: true)
        vc.setUp(cellVM: PhotoCellVM(photo: viewModel.photoResponse!.photo[indexPath.row]))
    }
}
