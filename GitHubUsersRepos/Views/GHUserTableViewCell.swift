//
//  GHUserTableViewCell.swift
//  GitHubUsersRepos
//
//  Created by Sirisha Dudiki on 10/8/19.
//  Copyright © 2019 GitHubUsersRepos. All rights reserved.
//

import UIKit

class GHUserTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var repositoryCount: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
