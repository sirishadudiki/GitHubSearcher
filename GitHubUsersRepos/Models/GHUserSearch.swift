//
//  GHUserSearch.swift
//  GitHubUsersRepos
//
//  Created by Sirisha Dudiki on 10/10/19.
//  Copyright © 2019 GitHubUsersRepos. All rights reserved.
//

import Foundation

struct GHUserSearch : Decodable {
    let total_count : Int
    let items : [GHUser]
}
