//
//  GHUserRepoTableViewCell.swift
//  GitHubUsersRepos
//
//  Created by Sirisha Dudiki on 10/10/19.
//  Copyright © 2019 GitHubUsersRepos. All rights reserved.
//

import UIKit

class GHUserRepoTableViewCell: UITableViewCell {

    @IBOutlet weak var repositoryName: UILabel!
    @IBOutlet weak var forksCount: UILabel!
    @IBOutlet weak var starsCount: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
