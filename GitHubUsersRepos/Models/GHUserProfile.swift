//
//  GHUserProfile.swift
//  GitHubUsersRepos
//
//  Created by Sirisha Dudiki on 10/10/19.
//  Copyright © 2019 GitHubUsersRepos. All rights reserved.
//

import Foundation

struct GHUserProfile : Decodable {
    let login : String
    let name : String?
    let location : String?
    let email : String?
    let followers : Int
    let following : Int
    let created_at : String
}
