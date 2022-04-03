//
//  DetailViewService.swift
//  AtLabsUserApp
//
//  Created by Fernando Gomes on 03/04/2022.
//

import Foundation
import Alamofire

class DetailViewService {
    
    static func getRepoList(username : String) -> [RepoDto]{
        var resultRepoList : [RepoDto] = []
        let semaphore = DispatchSemaphore(value: 0)
        AF.request(Constants.baseUrl + Constants.userUrl + username + Constants.reposUrl).responseJSON { response in
            if response.response?.statusCode == Constants.success {
                if let safeResponse = response.data  {
                    let decoder = JSONDecoder()
                    do{
                        resultRepoList = try decoder.decode([RepoDto].self, from: safeResponse)
                    }
                    catch {
                        print(error)
                    }
                } else {
                    print("Error")
                }
            }
            semaphore.signal()
        }
        semaphore.wait()
        return resultRepoList
    }
}
