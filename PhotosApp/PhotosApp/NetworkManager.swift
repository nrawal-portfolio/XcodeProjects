//
//  NetworkManager.swift
//  PhotosApp
//
//  Created by Neilkaran Rawal on 2/9/23.
//

import Foundation

class NetworkManager {
    
    static let sharedInstance = NetworkManager()
    private init() {}
    
    func fetchData(urlString: String, completion:@escaping(Result<[PhotosModel], Error>) -> Void){
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let errorReceived = error {
                completion(.failure(errorReceived))
            } else {
                guard let receivedData = data else {return}
                do {
                    let receivedModel = try JSONDecoder().decode([PhotosModel].self, from: receivedData)
                    completion(.success(receivedModel))
                }
                catch(let error){
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    
}
