//
//  ImageView+loadFromUrl.swift
//  AtLabsUserApp
//
//  Created by Fernando Gomes on 01/04/2022.
//

import UIKit
import Alamofire

extension UIImageView {
    
    func loadFromUrl(imageUrl: String){
        self.image = UIImage()
        DispatchQueue.global().async {
            AF.request(imageUrl).response{ response in
                if(response.data != nil){
                    let image = UIImage(data: response.data!)
                    self.image = image
                }
            }
        }
    }
}
