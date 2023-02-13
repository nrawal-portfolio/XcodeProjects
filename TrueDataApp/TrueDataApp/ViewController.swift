//
//  ViewController.swift
//  TrueDataApp
//
//  Created by Neilkaran Rawal on 2/10/23.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var titlesTableView: UITableView!
    
    //MARK: - Variables
    var todosViewModel: TodosViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        todosViewModel = TodosViewModel()
        
        todosViewModel?.fetchTrueData {
            DispatchQueue.main.async {
                self.titlesTableView.reloadData()
            }
        }
        
    }
    //MARK: - Configure TableView delegate & dataSource
    func configTableView(){
        titlesTableView.delegate = self
        titlesTableView.dataSource = self
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todosViewModel?.todosArray.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "titlesCell") as? TitlesTableViewCell
        else{
            return UITableViewCell()
        }
        let titles = todosViewModel?.todosArray[indexPath.row]
        cell.titleLbl.text = "Title:\(titles?.title ?? "")"
        return cell
    }
}

//MARK: - UITableViewCell
class TitlesTableViewCell: UITableViewCell{
    @IBOutlet weak var titleLbl: UILabel!
}

