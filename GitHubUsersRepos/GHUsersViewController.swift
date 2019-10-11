//
//  ViewController.swift
//  GitHubUsersRepos
//
//  Created by Sirisha Dudiki on 10/8/19.
//  Copyright © 2019 GitHubUsersRepos. All rights reserved.
//

import UIKit

class GHUsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var userTableView: UITableView!
    
    var userResults : [GHUser] = []
    var base64LoginString : String = ""
    var selectedUserRepoURL :String?
    var selectedLoginName : String?
    var selectedUserAvatar : UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = GHPageTitle
        print("Displaying top users on home screen.. until user starts search")
        getTopUsers()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (userResults.isEmpty)
        {
            getTopUsers()
        }
    }

    //MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        tableView.register(UINib.init(nibName: "GHUserTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: GHUserTableViewCellIdentifier)
        let userCell = tableView.dequeueReusableCell(withIdentifier: GHUserTableViewCellIdentifier, for: indexPath) as? GHUserTableViewCell

        userCell?.avatarImage.image = UIImage(named:"user-placeholder")

        let getUsersAvatarUrl = URL(string: userResults[row].avatar_url)
        var avatarUrlRequest = URLRequest(url: getUsersAvatarUrl!)
        avatarUrlRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")

        GHAPIRequestManager.performCloudRequest(avatarUrlRequest, success: { (status, data ) in
            if status == 200
            {
                if let imageData = data {
                    let image = UIImage(data: imageData)
                    DispatchQueue.main.async {
                        userCell?.avatarImage.image = image
                    }
                }
                else
                {
                    print("unable to get avatar image")
                }
            }}) { (error) in
                print("unable to get avatar image")
        }
        
        userCell?.userName.text = userResults[row].login

        let getReposUrl = URL(string: userResults[row].repos_url)
        var reposUrlRequest = URLRequest(url: getReposUrl!)

        reposUrlRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        GHAPIRequestManager.performCloudRequest(reposUrlRequest, success: { (status, data ) in
            if status == 200
            {
                if let reposData = data {
                    do {
                        let userRepoResults = try JSONDecoder().decode([GHUserRepos].self, from : reposData)
                        DispatchQueue.main.async {
                            userCell?.repositoryCount.text = "\(userRepoResults.count)"
                        }}
                    catch
                    {
                        print("unable to get avatar image")
                    }

                }}}) { (error) in
                    print("unable to get avatar image")
        }
        
        return userCell!
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 100.0
    }

    //MARK: - UISearchBarDelegate

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(retrieveUsers(_:)), object: searchBar)
        self.perform(#selector(retrieveUsers(_:)), with: searchBar, afterDelay: 0.5)
    }

    @objc private func retrieveUsers( _ searchBar : UISearchBar){

        guard let searchText = searchBar.text, searchText.trimmingCharacters(in: .whitespaces) != "" else {
            getTopUsers()
            return
        }
        let getUserSearchUrl = URL(string: "https://api.github.com/search/users?q="+searchText)
        var getUsersSearchUrlRequest = URLRequest(url: getUserSearchUrl!)
        getUsersSearchUrlRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")

        GHAPIRequestManager.performCloudRequest(getUsersSearchUrlRequest, success: { (status, data) in
            if status == 200
            {
                if let data = data {
                    do {
                        let searchResults = try JSONDecoder().decode(GHUserSearch.self, from: data)
                        self.userResults = searchResults.items
                        DispatchQueue.main.async {
                            self.userTableView.reloadData()
                        }
                        print("retrieved \(self.userResults.count) users")

                    } catch {
                        print("unable to get user details")
                    }
                }
            }
            else{
                print("unable to get user details")
                // Show appropriate error as per status codes
            }
        }) {(error) in
            print("unable to get user details")
        }
    }

    func getTopUsers()
    {
        let getUserUrl = URL(string: "https://api.github.com/users")
        let loginString = String(format: "%@:%@", githubLoginName, githubToken)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        base64LoginString = loginData.base64EncodedString()

        var getUsersUrlRequest = URLRequest(url: getUserUrl!)
        getUsersUrlRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")

        GHAPIRequestManager.performCloudRequest(getUsersUrlRequest, success: { (status, data) in
            if status == 200
            {
                if let data = data {
                    do {
                        self.userResults = try JSONDecoder().decode([GHUser].self, from: data)
                        DispatchQueue.main.async {
                            self.userTableView.reloadData()
                        }
                        print("retrieved \(self.userResults.count) users")

                    } catch {
                        print("unable to get user details")
                    }
                }
            }
            else{
                print("unable to get user details")
                // Show appropriate error as per status codes
            }
        }) {(error) in
            print("unable to get user details")
        }
    }

    //MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selcted row# \(indexPath.row)")

        let selectedCell = tableView.cellForRow(at: indexPath) as? GHUserTableViewCell
        selectedLoginName = selectedCell?.userName.text
        selectedUserAvatar = selectedCell?.avatarImage.image
        selectedUserRepoURL = userResults[indexPath.row].repos_url
        self.performSegue(withIdentifier: GHUserProfileSegueIdentifier, sender: self)
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // back button
        let backBarButton = UIBarButtonItem.init(title: "Users", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backBarButton


        if let controller = segue.destination as? GHUserProfileViewController
        {
            controller.loginName = selectedLoginName
            controller.userImage = selectedUserAvatar
            controller.usersReposUrl = selectedUserRepoURL
        }
    }
}

