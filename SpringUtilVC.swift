//
//  SpringUtilVC.swift
//  GGSwiftStudy
//
//  Created by Gorey on 16/11/30.
//  Copyright © 2016年 Gorey. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Spring

class SpringUtilVC: UIViewController{
    
    var lbTest:SpringLabel = {
        let a =  SpringLabel()
        a.textColor = R.color.red
        return a
    }()
    
    lazy var btnSetup:SpringButton = {
        let a = SpringButton()
        a.setTitle("Html", for: [])
        a.setTitleColor(R.color.darkGray, for: [])
        a.backgroundColor = R.color.lightGray
        a.addTarget(self, action: #selector(onClickHtmlText), for: .touchUpInside)
        a.sizeToFit()
        return a
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = R.color.white
        
        view.addSubview(lbTest)
        lbTest.frame = CGRect(x: 10, y: 100, width: 100, height: 30)
        lbTest.text = "hello world"
        
        view.addSubview(btnSetup)
        btnSetup.sm { m in
            m.pl(10).pt(500).w(100).h(30)
        }
        
        debugPrint(timeAgoSinceDate(date:Date(), numericDates: true))
    }
    
    func onClickHtmlText(){
        let htmlStr = "<B><del>Grubby</del></B>"
        let attrStr = htmlToAttributedString(text: htmlStr)
        
        // 延时两2秒执行
        delay(delay: 2) { 
            self.lbTest.attributedText = attrStr
            self.lbTest.animation = "pop"
            self.lbTest.animate()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        SpringAnimation.springWithDelay(duration: 1.0, delay: 1.0) { 
            self.lbTest.animation = "morph"
            self.lbTest.animate()
        }
        
    }
    
}
