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
import RxSwift

class ReposTableViewController: UITableViewController {
    let reposViewModel = ReposViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reposViewModel.driver.drive(onNext: { (repos) in
            for repo in repos {
                print(repo.fullName)
            }
        }, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    
    @IBAction func didTouchUpItemButton(_ sender: Any) {
        reposViewModel.fetchData()
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
