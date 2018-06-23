//
//  TableViewController.swift
//  Study-Himotoki-Realm-RxSwift
//
//  Created by Takayuki Sei on 2018/06/22.
//  Copyright © 2018年 Takayuki Sei. All rights reserved.
//

import UIKit
import RealmSwift
import Himotoki
import Alamofire

class TableViewController: UITableViewController {
    @IBAction func add(_ sender: Any) {
        APIRequest.request { (users) in
            let realm = try! Realm()
            try! realm.write {
                for user in users.users {
                    realm.add(user)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let user = User()
//        user.name = "ore"
//        user.age = 29
//
//        let realm = try! Realm()
//
//        try! realm.write {
//            realm.add(user)
//        }
//
//        DispatchQueue(label: "background").async {
//            autoreleasepool {
//                let realm = try! Realm()
//                let users = realm.objects(User.self)
//                print(users)
//            }
//        }
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

final class User: Object, Himotoki.Decodable {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var age = 0
    
    static func decode(_ e: Extractor) throws -> User {
        let user = User()
        user.id = try! e <| "id"
        user.name = try! e <| "name"
        user.age = try! e <| "age"
        return user
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

final class Users: Himotoki.Decodable {
    var users = [User]()

    static func decode(_ e: Extractor) throws -> Users {
        let users = Users()
        users.users = try e <|| "users"
        return users
    }
}

struct APIRequest {
    static func request(completion: @escaping (Users) -> Void) {
        Alamofire.request(URL(string: "http://localhost:8080")!).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let users = try! Users.decodeValue(value)
                completion(users)
            case .failure(let error):
                print("error \(error.localizedDescription)")
            }
        }
    }
}
