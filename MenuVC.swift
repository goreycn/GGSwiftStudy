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

class MenuVC : UIViewController {
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, User>>()
    let viewModel = UserViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            return cell
        }
        
        viewModel.getUsers().bindTo(tableView.rx.items(dataSource:dataSource)).addDisposableTo(disposeBag)
    }
    
    
    lazy var tableView : UITableView = {
        let a = UITableView()
        a.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return a
    }()
}