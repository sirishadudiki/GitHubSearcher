//
//  GHUser.swift
//  GitHubUsersRepos
//
//  Created by Sirisha Dudiki on 10/9/19.
//  Copyright © 2019 GitHubUsersRepos. All rights reserved.
//

import Foundation

/*
 {
   "login": "TommyZihao",
   "id": 36354458,
   "node_id": "MDQ6VXNlcjM2MzU0NDU4",
   "avatar_url": "https://avatars0.githubusercontent.com/u/36354458?v=4",
   "gravatar_id": "",
   "url": "https://api.github.com/users/TommyZihao",
   "html_url": "https://github.com/TommyZihao",
   "followers_url": "https://api.github.com/users/TommyZihao/followers",
   "following_url": "https://api.github.com/users/TommyZihao/following{/other_user}",
   "gists_url": "https://api.github.com/users/TommyZihao/gists{/gist_id}",
   "starred_url": "https://api.github.com/users/TommyZihao/starred{/owner}{/repo}",
   "subscriptions_url": "https://api.github.com/users/TommyZihao/subscriptions",
   "organizations_url": "https://api.github.com/users/TommyZihao/orgs",
   "repos_url": "https://api.github.com/users/TommyZihao/repos",
   "events_url": "https://api.github.com/users/TommyZihao/events{/privacy}",
   "received_events_url": "https://api.github.com/users/TommyZihao/received_events",
   "type": "User",
   "site_admin": false,
   "score": 62.535473
 }

 */

struct GHUser : Decodable {
    let login : String
    let id : Int
    let  avatar_url : String
    let repos_url : String
    let followers_url : String
    let following_url : String

}
