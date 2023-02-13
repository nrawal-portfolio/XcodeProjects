//
//  PhotosViewModel.swift
//  PhotosApp
//
//  Created by Neilkaran Rawal on 2/9/23.
//

import Foundation


class PhotosViewModel{
    var photosArray: [PhotosModel] = []
    
    func fetchPhotosData(completion:@escaping () -> Void){
        NetworkManager.sharedInstance.fetchData(urlString: Constants.urls.photosData.rawValue) { result in
            switch result {
            case .success(let photoData):
                self.photosArray = photoData
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
}



