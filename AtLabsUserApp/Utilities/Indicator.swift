//
//  Indicator.swift
//  AtLabsUserApp
//
//  Created by Fernando Gomes on 01/04/2022.
//

import UIKit

fileprivate let spinner = SpinnerViewController()
extension UIViewController{
    
    func startIndicator(alpha : CGFloat = 0.4){
        spinner.view.backgroundColor = UIColor(white: 0, alpha: alpha)
        self.addChild(spinner)
        spinner.view.frame = self.view.frame
        self.view.addSubview(spinner.view)
        spinner.didMove(toParent: self)
    }

    func stopIndicator(){
        spinner.willMove(toParent: nil)
        spinner.view.removeFromSuperview()
        spinner.removeFromParent()
    }
}
