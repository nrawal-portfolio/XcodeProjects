//
//  ViewController.swift
//  SingleUserInfo
//
//  Created by Neilkaran Rawal on 2/10/23.
//

import UIKit

class ViewController: UIViewController {
    
    var userViewModel: UserViewModel?
    
    //MARK: - IBOutlets
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var createdLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userViewModel = UserViewModel()
        displayUserData()
        // Do any additional setup after loading the view.
        
    }
    
     func userData() {
        //print(self.userViewModel?.userInfo?.name ?? "Default-Value")
        let userObj = self.userViewModel?.userInfo
        self.nameLbl.text = userObj?.name ?? "Default-Value"
        self.heightLbl.text = userObj?.height ?? "Default-Value"
        let dateFormatReceived = DateFormatter()
        dateFormatReceived.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let dateFormatDisplay = DateFormatter()
        dateFormatDisplay.dateFormat = "MM-dd-yyyy"
         if let date = dateFormatReceived.date(from: userObj?.created ?? "") {
             self.createdLbl.text = dateFormatDisplay.string(from: date)
         } else {
             self.createdLbl.text = "Default-Value"
         }
    }
    
    func displayUserData(){
        userViewModel?.fetchUserData {
            DispatchQueue.main.async {
                self.userData()
            }
        }
       
    }


}

