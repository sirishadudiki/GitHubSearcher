//
//  GHUserRepos.swift
//  GitHubUsersRepos
//
//  Created by Sirisha Dudiki on 10/10/19.
//  Copyright © 2019 GitHubUsersRepos. All rights reserved.
//

import Foundation

struct GHUserRepos : Decodable {
    let id : Int64
    let name : String
    let stargazers_count : Int
    let forks_count : Int
    let html_url : String
    
}
