//
//  LoginWithRxVC.swift
//  GGSwiftStudy
//
//  Created by Gorey on 16/10/13.
//  Copyright © 2016年 Gorey. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit


class LoginWithRxVC : UIViewController  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
        
        title = "Login in RxSwift"
        
        setupSubviews()
        
        btnLogin.addTarget(self, action: #selector(onClickLogin), for: .touchUpInside)
        
        _ = Observable.combineLatest(tfUsername.rx.text, tfPassword.rx.text) { ($0, $1) }
            .map{ ($0?.characters.count)! > 6 && ($1?.characters.count)! > 6 }
            .bindTo(btnLogin.rx.isEnabled)
 
    }
    
    func onClickLogin(){
        debugPrint("clicked Login")
    }
    
    
    func setupSubviews(){
        view.addSubview(tfUsername)
        tfUsername.snp.makeConstraints { (m) in
            m.left.equalTo(self.view).offset(10)
            m.right.equalTo(self.view).offset(-10)
            m.top.equalTo(self.view).offset(10)
            m.height.equalTo(40)
        }
        
        view.addSubview(tfPassword)
        tfPassword.snp.makeConstraints { (m) in
            m.left.equalTo(self.view).offset(10)
            m.right.equalTo(self.view).offset(-10)
            m.top.equalTo(self.tfUsername.snp.bottom).offset(10)
            m.height.equalTo(40)
        }
        
        view.addSubview(btnLogin)
        btnLogin.snp.makeConstraints { (m) in
            m.left.equalTo(self.view).offset(10)
            m.right.equalTo(self.view).offset(-10)
            m.top.equalTo(self.tfPassword.snp.bottom).offset(20)
            m.height.equalTo(40)
        }
    }
    
    
    lazy var tfUsername : UITextField = {
        let a = UITextField()
        a.borderStyle = .roundedRect
        a.placeholder = "input username"
        return a
    }()
    
    lazy var tfPassword : UITextField = {
        let a = UITextField()
        a.borderStyle = .roundedRect
        a.isSecureTextEntry = true
        a.placeholder = "input password"
        return a
    }()
    
    lazy var btnLogin : UIButton = {
        let a = UIButton(type: .roundedRect)
        a.setTitle("Login", for: [])
        a.setTitleColor(UIColor.white, for: [])
        a.backgroundColor = UIColor.blue
        return a
    }()
}
