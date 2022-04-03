//
//  UserDto.swift
//  AtLabsUserApp
//
//  Created by Fernando Gomes on 01/04/2022.
//

import Foundation

struct UserDto : Codable {
    
    let login : String
    let avatar_url : String 
    let name : String?
    let bio : String?
    let public_repos : Int
    let followers : Int

}
