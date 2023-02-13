//
//  ThumbnailViewController.swift
//  PhotosApp
//
//  Created by Neilkaran Rawal on 2/10/23.
//

import UIKit

class ThumbnailViewController: UIViewController {
    
    //MARK: - Variables
    var photoViewModel: PhotosViewModel?
    
    //MARK: - IBOutlets
    @IBOutlet weak var thumbnailCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        photoViewModel = PhotosViewModel()
        
        photoViewModel?.fetchPhotosData {
            DispatchQueue.main.async{
                self.thumbnailCollectionView.reloadData()
            }
        }
    }
    //MARK: - Configure CollectionView delegate & dataSource
    func configCollectionView(){
        thumbnailCollectionView.delegate = self
        thumbnailCollectionView.dataSource = self
    }
}
//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ThumbnailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoViewModel?.photosArray.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "thumbnailCell", for: indexPath) as? ThumbnailCollectionViewCell else { return UICollectionViewCell() }
        let thumbnail = photoViewModel?.photosArray[indexPath.row]
        cell.thumbnailImage.load(urlString: thumbnail?.thumbnailUrl ?? "")
        return cell
    }
}
//MARK: - UICollectionViewCell
class ThumbnailCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var thumbnailImage: UIImageView!
}
