//
//  Constants.swift
//  AtLabsUserApp
//
//  Created by Fernando Gomes on 01/04/2022.
//

import Foundation

struct Constants {
    
    // MARK: - URL
    
    static let baseUrl = "https://api.github.com/"
    static let userUrl = "users/"
    static let reposUrl = "/repos"
    
    //MARK: - Status Code
    static let success = 200
    
    //MARK: Localizable Constants
    //No internet alert
    static let noInternet_title = "noInternet_title"
    static let noInternet_description = "noInternet_description"
    
    static let ok = "ok"
    
    //Card
    static let followers_label = "followers_label"
    static let repos_label = "repos_label"
    static let bio_label = "bio"
    
    //User 404 Alert
    static let user_not_found_title = "user_not_found_title"
    static let user_not_found_body = "user_not_found_body"
    
    //MARK: - Cells
    static let repo_detail_cell = "repoDetails"
    
    //MARK: - Segues
    static let to_detail = "toDetail"
    
}
