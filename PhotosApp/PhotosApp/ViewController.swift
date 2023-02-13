//
//  ViewController.swift
//  PhotosApp
//
//  Created by Neilkaran Rawal on 2/9/23.
//

import UIKit

class ViewController: UIViewController {
//MARK: - IBOutlets
    @IBOutlet weak var photosTableView: UITableView!
    
    var photosViewModel: PhotosViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        photosViewModel = PhotosViewModel()
        
        photosViewModel?.fetchPhotosData {
            DispatchQueue.main.async {
                self.photosTableView.reloadData()
            }
        }
    }
    
    func configureTableView(){
        photosTableView.delegate = self
        photosTableView.dataSource = self
    }

}
//MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photosViewModel?.photosArray.count ?? 0 
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "photosCell") as? photosTableViewCell
        else {
            return UITableViewCell()
        }
        let album = photosViewModel?.photosArray[indexPath.row]
        cell.title.text = "Title:\(album?.title ?? "")"
        cell.thumbnailPhoto.load(urlString: album?.url ?? "")
        
        return cell
    }
}

//MARK: - UITableViewCell
class photosTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var thumbnailPhoto: UIImageView!
}

//extension UIImageView {
//    func loadFrom(URLAddress: String) {
//        guard let url = URL(string: URLAddress) else {
//            return
//        }
//        if let imageData = try? Data(contentsOf: url) {
//            if let loadedImage = UIImage(data: imageData) {
//                DispatchQueue.main.async{
//                    self.image = loadedImage
//                }
//            }
//        }
//    }
//}
//MARK: - UIImageView 
extension UIImageView {
    func load(urlString : String) {
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
