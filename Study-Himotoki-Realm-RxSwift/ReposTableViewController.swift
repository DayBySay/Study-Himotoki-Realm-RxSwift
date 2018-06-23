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
import RxCocoa

class ReposTableViewController: UITableViewController {
    let reposViewModel = ReposViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupBinding()
    }
    
    @IBAction func didTouchUpItemButton(_ sender: Any) {
        reposViewModel.fetchData()
    }
    
    func setupTableView() {
        tableView.delegate = nil
        tableView.dataSource = nil
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.register(UINib(nibName: "RepoTableViewCell", bundle: nil), forCellReuseIdentifier: "RepoTableViewCell")
    }
    
    func setupBinding() {
        reposViewModel
            .driver
            .asObservable()
            .bind(to: self.tableView.rx.items(cellIdentifier: "RepoTableViewCell")) { (row, element, cell) in
                let c = cell as! RepoTableViewCell
                c.setRepo(repo: element)
            }
            .disposed(by: disposeBag)
    }
}
