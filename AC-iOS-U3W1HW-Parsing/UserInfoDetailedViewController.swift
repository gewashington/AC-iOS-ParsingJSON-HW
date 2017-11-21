//
//  UserInfoDetailedViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/17/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class UserInfoDetailedViewController: UIViewController {
    var userInfo: People? = nil
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let userInfo = userInfo else {
            return
        }
       
        userNameLabel.text? = userInfo.login.username
        emailLabel.text? = userInfo.email
        phoneLabel.text? = userInfo.phone
        cellLabel.text? = userInfo.cell
        
        if let url = URL(string: userInfo.picture.large) {
            DispatchQueue.global().sync {
                if let data = try? Data.init(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.userImage.image = UIImage(data: data)
                    }
                    
                }
            }
        }
//        if let url = URL(string: user.picture.thumbnail) {
//            DispatchQueue.global().sync { //sync works in the background
//                if let data = try? Data.init(contentsOf: url) {
//                    DispatchQueue.main.async { //sync works in foreground
//                        cell.imageView?.image = UIImage(data: data)
//                    }
//                }
//            }
//        }

        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
