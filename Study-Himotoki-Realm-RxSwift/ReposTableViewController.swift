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
        
        let refreshControl = UIRefreshControl()
        refreshControl.rx.controlEvent(.valueChanged)
            .subscribe({_ in 
                self.refreshControl?.beginRefreshing()
                self.reposViewModel.fetchData()
            })
        .disposed(by: disposeBag)
        tableView.refreshControl = refreshControl

        reposViewModel.fetchData()
    }
    
    func setupTableView() {
        tableView.delegate = nil
        tableView.dataSource = nil
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.register(UINib(nibName: "RepoTableViewCell", bundle: nil), forCellReuseIdentifier: "RepoTableViewCell")
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [unowned self] indexPath in
                let cell = self.tableView.cellForRow(at: indexPath) as? RepoTableViewCell
                cell?.openRepository(target: self)
            }).addDisposableTo(disposeBag)
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
        
        reposViewModel.driver.drive(onNext: { (repos) in
            self.tableView.refreshControl?.endRefreshing()
        }, onCompleted: nil, onDisposed: nil)
        .disposed(by: disposeBag)
    }
}
