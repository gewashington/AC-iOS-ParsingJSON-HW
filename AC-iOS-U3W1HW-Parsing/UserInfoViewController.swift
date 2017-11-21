//
//  UserInfoViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var userInfoTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var users = [People]()
    
    var searchWord: String? {
        didSet {
            userInfoTableView.reloadData()
        }
    }
    
    
    var filteredUserInfo: [People] {
        guard let searchWord = searchWord, searchWord != "" else {
            return users
        }
        return users.filter{
            ($0.name.first.lowercased() + " " + $0.name.last.lowercased()).contains(searchWord.lowercased())            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userInfoTableView.delegate = self
        userInfoTableView.dataSource = self
        searchBar.delegate = self
        loadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredUserInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = filteredUserInfo[indexPath.row]
        let cell = userInfoTableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        cell.textLabel?.text = "\(user.name.title) \(user.name.first) \(user.name.last)"
        cell.detailTextLabel?.text = "\(user.location.city) \(user.location.state)"
        if let url = URL(string: user.picture.thumbnail) {
            DispatchQueue.global().sync { //sync works in the background
                if let data = try? Data.init(contentsOf: url) {
                    DispatchQueue.main.async { //sync works in foreground
                        cell.imageView?.image = UIImage(data: data)
                    }
                }
            }
        }
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchWord = searchBar.text
        searchBar.resignFirstResponder()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchWord = searchText
        
    }
    
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                let decoder = JSONDecoder()
                do {
                    let userInfo = try decoder.decode(Users.self, from: data)
                    self.users = userInfo.results
                }
                catch let error { //decide whether or not to keep this
                    print(error)
                }
            }
        }
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? UserInfoDetailedViewController {
            destination.userInfo = users[userInfoTableView.indexPathForSelectedRow!.row]
        }
    }
    
}
