//
//  UserViewModel.swift
//  SingleUserInfo
//
//  Created by Neilkaran Rawal on 2/10/23.
//

import Foundation

class UserViewModel {
    var userInfo: UserModel?
    
    func fetchUserData(completion:@escaping () -> Void){
        NetworkManager.sharedInstance.fetchData(urlString: Constants.urls.userOne.rawValue) { [weak self] result in
            switch result {
            case .success(let userData):
                self?.userInfo = userData
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
}

