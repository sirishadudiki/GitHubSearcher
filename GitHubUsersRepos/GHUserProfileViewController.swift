//
//  GHUserProfileViewController.swift
//  GitHubUsersRepos
//
//  Created by Sirisha Dudiki on 10/10/19.
//  Copyright © 2019 GitHubUsersRepos. All rights reserved.
//

import UIKit

class GHUserProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var emailAddress: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var joiningDate: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var repositoriesTableView: UITableView!
    @IBOutlet weak var userAvatarImage: UIImageView!
    
    var repositoriesList : [GHUserRepos]?
    var loginName : String?
    var userImage : UIImage?
    var usersReposUrl : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = GHPageTitle

        self.userAvatarImage.image = userImage
        guard let loginName = loginName, let url = usersReposUrl else { return}
        getUserProfileData(loginName)
        getUserRepositories(url: URL(string:url)!)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    //MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repositoriesList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UINib.init(nibName: "GHUserRepoTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: GHUserRepoTableViewCellIdentifier)
        let repoCell = tableView.dequeueReusableCell(withIdentifier: GHUserRepoTableViewCellIdentifier, for: indexPath) as? GHUserRepoTableViewCell

        if let list = repositoriesList
        {
            repoCell?.repositoryName.text = list[indexPath.row].name
            repoCell?.forksCount.text = "\(list[indexPath.row].forks_count)"
            repoCell?.starsCount.text = "\(list[indexPath.row].stargazers_count)"
        }

        return repoCell ?? UITableViewCell()
    }

    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let urlString = repositoriesList?[indexPath.row].html_url  else { return }
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

    //MARK: - UISearchBarDelegare
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(retrieveUsersRepos(_:)), object: searchBar)
        self.perform(#selector(retrieveUsersRepos(_:)), with: searchBar, afterDelay: 0.5)
    }

    @objc private func retrieveUsersRepos( _ searchBar : UISearchBar){
        guard let searchText = searchBar.text, searchText.trimmingCharacters(in: .whitespaces) != "" else {
            return
        }
        let getUserReposSearchUrl = URL(string: usersReposUrl!+"?q="+searchText)
        getUserRepositories(url: getUserReposSearchUrl!)
    }

    func getUserRepositories( url : URL)
    {
        var getUsersReposSearchUrlRequest = URLRequest(url: url)
        let loginString = String(format: "%@:%@", githubLoginName, githubToken)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        getUsersReposSearchUrlRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")

        GHAPIRequestManager.performCloudRequest(getUsersReposSearchUrlRequest, success: {[weak self] (status, data) in
            guard let strongSelf = self else { return}
            if status == 200
            {
                if let data = data {
                    do {
                        strongSelf.repositoriesList = try JSONDecoder().decode([GHUserRepos].self, from: data)
                        
                        DispatchQueue.main.async {
                            strongSelf.repositoriesTableView.reloadData()
                        }

                    } catch {
                        print("unable to get user repo details")
                    }
                }
            }
            else{
                print("unable to get user repo details")
                // Show appropriate error as per status codes
            }
        }) {(error) in
            print("unable to get user repo details")
        }
    }

    //MARK: - NetworkCalls

    func getUserProfileData(_ loginName : String)
    {
        let getUserProfileUrl = URL(string: "https://api.github.com/users/"+loginName)
        let loginString = String(format: "%@:%@", githubLoginName, githubToken)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()

        var getUserProfileUrlRequest = URLRequest(url: getUserProfileUrl!)
        getUserProfileUrlRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")

        GHAPIRequestManager.performCloudRequest(getUserProfileUrlRequest, success: {[weak self] (status, data) in
           guard let strongSelf = self else { return}
            if status == 200
            {
                if let data = data {
                    do {
                        let profile = try JSONDecoder().decode(GHUserProfile.self, from: data)

                        DispatchQueue.main.async {
                            strongSelf.userName.text = profile.name
                            strongSelf.emailAddress.text = profile.email
                            strongSelf.followersCount.text = "\(profile.followers)"
                            strongSelf.followingCount.text = "\(profile.following)"
                            strongSelf.joiningDate.text = profile.created_at
                            strongSelf.location.text = profile.location
                        }
                    } catch {
                        print("unable to get user profile")
                    }
                }
            }
            else{
                print("unable to get user profile")
                // Show appropriate error as per status codes
            }
        }) {(error) in
            print("unable to get user profile")
        }
    }
}
