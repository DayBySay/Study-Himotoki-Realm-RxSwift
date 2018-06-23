//
//  RepoTableViewCell.swift
//  Study-Himotoki-Realm-RxSwift
//
//  Created by Takayuki Sei on 2018/06/23.
//  Copyright © 2018年 Takayuki Sei. All rights reserved.
//

import UIKit
import PINRemoteImage

class RepoTableViewCell: UITableViewCell {
    let identifier = "RepoTableViewCell"
    @IBOutlet weak var reponameLabel: UILabel!
    @IBOutlet weak var ownerAvaterImageView: UIImageView!
    var repo: Repo!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setRepo(repo: Repo) {
        self.repo = repo
        reponameLabel.text = repo.fullName
        ownerAvaterImageView.pin_setImage(from: repo.avatarUrl)
    }
}
