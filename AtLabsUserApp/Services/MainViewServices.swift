//
//  MainViewServices.swift
//  AtLabsUserApp
//
//  Created by Fernando Gomes on 01/04/2022.
//

import Foundation
import Alamofire

class MainViewServices {
    
    static func getPostList(username : String) -> UserDto?{
        var resultUser : UserDto? = nil
        let semaphore = DispatchSemaphore(value: 0)
        AF.request(Constants.baseUrl + Constants.userUrl + username).responseJSON { response in
            if response.response?.statusCode == Constants.success {
                if let safeResponse = response.data  {
                    let decoder = JSONDecoder()
                    do{
                        resultUser = try decoder.decode(UserDto.self, from: safeResponse) 
                    }
                    catch {
                        print("Entro aqui")
                    }
                } else {
                    print("Error")
                }
            } else {
                print(response.response?.statusCode)
            }
            semaphore.signal()
        }
        semaphore.wait()
        return resultUser
    }
    
}
