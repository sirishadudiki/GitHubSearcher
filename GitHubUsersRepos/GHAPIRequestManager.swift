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

    typealias NetworkResponseSuccess = (_ status : Int?, _ response : Data?) -> ()
    typealias NetworkResponseFailure = (_ error : NSError) -> ()

    static func performCloudRequest( _ request : URLRequest, success : @escaping NetworkResponseSuccess, failure : @escaping NetworkResponseFailure)
    {
        let sessionDataTask = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in

            if let response = response as? HTTPURLResponse
            {
                success(response.statusCode, data)
            }
            else
            {
                failure(error! as NSError)
            }
        })

        sessionDataTask.resume()
    }
}

