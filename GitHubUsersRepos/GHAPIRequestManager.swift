//
//  GHAPIRequestManager.swift
//  GitHubUsersRepos
//
//  Created by Sirisha Dudiki on 10/9/19.
//  Copyright © 2019 GitHubUsersRepos. All rights reserved.
//

import Foundation

class GHAPIRequestManager: NSObject {

    static let LOGTAG = "GHAPIRequestManager"
    static let sharedManager = GHAPIRequestManager()

    static func performCloudRequest( _ request : URLRequest, success : @escaping ((_ status : Int?, _ response : Data?) -> ()), failure : @escaping (_ error : NSError) -> ())
    {
        let sessionDataTask = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in

            if let response = response as? HTTPURLResponse
            {
                DispatchQueue.main.async(execute: {
                    success(response.statusCode, data)
                })
            }
            else
            {
                DispatchQueue.main.async(execute: {
                    failure(error! as NSError)
                })
            }
        })

        sessionDataTask.resume()
    }

    static func getUsersSearch(data : Data) -> [GHUser]?
    {
        do {
             let users = try JSONDecoder().decode([GHUser].self, from: data)
            return users
        } catch {
            print("Error: Couldn't decode data to SFOTScheduleModel")
            return nil
        }
    }
}

