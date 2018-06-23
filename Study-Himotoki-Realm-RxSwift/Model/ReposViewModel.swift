//
//  ReposViewModel.swift
//  Study-Himotoki-Realm-RxSwift
//
//  Created by Takayuki Sei on 2018/06/23.
//  Copyright © 2018年 Takayuki Sei. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ReposViewModel {
    private let repos = BehaviorRelay(value: [Repo]())
    var driver: Driver<[Repo]> {
        return repos.asDriver()
    }
    
    func fetchData() {
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
            
            self.repos.accept(repos)
        }
    }
}
