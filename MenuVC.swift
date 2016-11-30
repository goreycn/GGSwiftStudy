//
//  Menu.swift
//  GGSwiftStudy
//
//  Created by Gorey on 16/10/12.
//  Copyright © 2016年 Gorey. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxCocoa
import RxSwift
import RxDataSources
import Spring

class MenuVC : UIViewController, UITableViewDelegate {
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, User>>()
    let viewModel = UserViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        gg_transparentNavigationBar()
        
        view.backgroundColor = UIColor.white
        title = "Grubby˚∆˚"
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ m in
            m.edges.equalTo(self.view)
        }
        
        dataSource.configureCell = {
            _, tableview, indexPath, user in
            let cell = tableview.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()
            cell.tag = indexPath.row
            cell.textLabel?.text = user.screenName
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        
        viewModel.getUsers().bindTo(tableView.rx.items(dataSource:dataSource)).addDisposableTo(disposeBag)
    }
    
    
    lazy var tableView : UITableView = {
        let a = UITableView()
        a.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        a.delegate = self
        return a
    }()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            pushvc(LoginWithRxVC.self)
        case 1:
            pushvc(RxSwiftStudyVC.self)
        case 2:
            pushvc(RxDataSourceVC.self)
        case 3:
            pushvc(RxDemoVC.self)
        case 4:
            let vc = SpringOptionVC()
            vc.modalPresentationStyle = .overCurrentContext
            vc.delegate = self
//            self.modalTransitionStyle = .coverVertical
//            self.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false, completion: nil)
        default:
            debugPrint("nothing")
        }
    }
    
    func pushvc(_ vc:AnyClass) {        
        if vc is UIViewController.Type {
            navigationController?.pushViewController((vc as! UIViewController.Type).init(), animated: true)
        }
    }
    
    func presentvc(_ vc: AnyClass) {
        if vc is UIViewController.Type {
            let c = (vc as! UIViewController.Type).init()
            c.modalPresentationStyle = .overCurrentContext
            self.present(c, animated: true, completion: nil)
        }
    }
    
    
    func minimizeView(_ sender:AnyObject) {
        UIApplication.shared.statusBarStyle = .lightContent
        SpringAnimation.spring(duration: 0.7) { 
            self.view.transform = CGAffineTransform(scaleX: 0.935, y: 0.935)
        }
    }
    
    func maximizeView(_ sender:AnyObject){
        UIApplication.shared.statusBarStyle = .default
        SpringAnimation.spring(duration: 0.7) { 
            self.view.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }

    
}
