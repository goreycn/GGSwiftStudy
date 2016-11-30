//
//  UIViewControllerExt.swift
//  GGSwiftStudy
//
//  Created by Gorey on 16/11/29.
//  Copyright © 2016年 Gorey. All rights reserved.
//

import Foundation
import UIKit

public extension UIViewController {
    
    
    func gg_transparentNavigationBar(){
        
        if let nc = self.navigationController {
            nc.navigationBar.setBackgroundImage(UIImage(named:"clear"), for: .any, barMetrics: .default)
            nc.navigationBar.isTranslucent = true
            nc.navigationBar.shadowImage = UIImage(named: "clear")            
        }
        
    }
    
}
