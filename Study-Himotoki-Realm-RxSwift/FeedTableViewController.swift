//
//  FeedTableViewController.swift
//  Study-Himotoki-Realm-RxSwift
//
//  Created by Takayuki Sei on 2018/06/23.
//  Copyright © 2018年 Takayuki Sei. All rights reserved.
//

import UIKit
import Alamofire

class FeedTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://github.com/ReactiveX/RxSwift/releases.atom")!
        let apiClient = APIClient(client: AlamofireClient())
        apiClient.request(url: url) { (data) in
            print("data dayo \(data)")
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

struct APIClient {
    let client: APIClientProtocol
    
    init(client: APIClientProtocol) {
        self.client = client
    }
    
    func request(url: URL, completion: @escaping (_ responseJSON: Data) -> Void) {
        client.request(url: url, completion: completion)
    }
}

struct AlamofireClient: APIClientProtocol {
    func request(url: URL, completion: @escaping (_ responseJSON: Data) -> Void) {
        Alamofire.request(url).responseData { (response) in
            completion(response.data!)
        }
    }
}

protocol APIClientProtocol {
    func request(url: URL, completion: @escaping (_ responseJSON: Data) -> Void)
}
