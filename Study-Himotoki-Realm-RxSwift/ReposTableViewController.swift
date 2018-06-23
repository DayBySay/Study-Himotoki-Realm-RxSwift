//
//  FeedTableViewController.swift
//  Study-Himotoki-Realm-RxSwift
//
//  Created by Takayuki Sei on 2018/06/23.
//  Copyright © 2018年 Takayuki Sei. All rights reserved.
//

import UIKit
import Alamofire
import Himotoki

class ReposTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let request = URLAPIRequest()
        let apiClient = AlamofireClient()
        let url = URL(string: "https://api.github.com/users/daybysay/repos")!
        
        let loader = MyAPIRequestLoader(apiRequest: request, apiClient: apiClient)
        loader.loadAPIRequest(requestData: url) { (repos, error) in
            if let error = error {
                print("error \(error)")
                return
            }
            
            guard let repos = repos else {
                print("undefined error T_T")
                return
            }
            
            for repo in repos {
                print(repo.fullName)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
}
