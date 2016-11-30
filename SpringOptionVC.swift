//
//  SpringVC.swift
//  GGSwiftStudy
//
//  Created by Gorey on 16/11/29.
//  Copyright © 2016年 Gorey. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Spring

class SpringOptionVC: UIViewController {
    
    weak var delegate:UIViewController? = nil
    
    lazy var btnClose : UIButton = {
        let a = UIButton(type: .custom)
        a.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        
        return a
    }()
    
    lazy var vBottom : SpringView = {
        let a = SpringView()
        a.backgroundColor = R.color.red
        a.animation = "squeezeUp"
        a.animateFrom = true
        return a
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = R.color.clear
        
        view.addSubview(vBottom)
        vBottom.snp.makeConstraints { m in
            m.left.right.equalTo(self.view)
            m.height.equalTo(400)
            m.bottom.equalTo(self.view).offset(80)
        }
        
        view.addSubview(btnClose)
        btnClose.snp.makeConstraints { m in
            m.left.top.right.equalTo(self.view)
            m.bottom.equalTo(self.vBottom.snp.top)

        }
        
        vBottom.transform = CGAffineTransform(translationX: 0, y: -R.dimens.winH)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        vBottom.animate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
        UIApplication.shared.sendAction(#selector(MenuVC.minimizeView(_:)), to: self.delegate, from: self, for: nil)
    }
    
    func closeButtonPressed(){
        dismiss(animated: true, completion: nil)
        
        UIApplication.shared.sendAction(#selector(MenuVC.maximizeView(_:)), to: self.delegate, from: self, for: nil)
    }
}
