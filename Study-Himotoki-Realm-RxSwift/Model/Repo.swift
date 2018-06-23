//
//  Repo.swift
//  Study-Himotoki-Realm-RxSwift
//
//  Created by Takayuki Sei on 2018/06/23.
//  Copyright © 2018年 Takayuki Sei. All rights reserved.
//

import Foundation
import Himotoki

struct Repo: Himotoki.Decodable {
    let fullName: String
    let url: URL
    let avatarUrl: URL
    
    static func decode(_ e: Extractor) throws -> Repo {
        let urlString: String = try e <| "html_url"
        let url = URL(string: urlString)!
        let avatarUrlString: String = try e  <| ["owner", "avatar_url"]
        let avatarUrl = URL(string: urlString)!
        
            return try Repo(
            fullName: e <| "full_name",
            url: url,
            avatarUrl: avatarUrl)
    }
}
