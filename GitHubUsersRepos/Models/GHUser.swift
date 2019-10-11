//
//  GHUser.swift
//  GitHubUsersRepos
//
//  Created by Sirisha Dudiki on 10/9/19.
//  Copyright © 2019 GitHubUsersRepos. All rights reserved.
//

import Foundation

struct GHUser : Decodable {
    let login : String
    let id : Int
    let  avatar_url : String
    let repos_url : String
    let followers_url : String
    let following_url : String

}
