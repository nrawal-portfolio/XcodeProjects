//
//  TodosViewModel.swift
//  TrueDataApp
//
//  Created by Neilkaran Rawal on 2/10/23.
//

import Foundation

class TodosViewModel {
    var todosArray: [TodosModel] = []
    
    func fetchTrueData(completion:@escaping () -> Void){
        NetworkManager.sharedInstance.fetchData(urlString: Constants.urls.todos.rawValue) { result in
            switch result{
            case .success(let trueData):
                self.todosArray = trueData
                //let trueTitles = self.todosArray.filter { $0.completed == true }
                let trueTitles = self.todosArray.filter { value in value.completed == true}
                self.todosArray = trueTitles
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
