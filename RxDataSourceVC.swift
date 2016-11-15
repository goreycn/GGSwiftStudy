//
//  RxDataSource.swift
//  GGSwiftStudy
//
//  Created by Gorey on 16/11/15.
//  Copyright © 2016年 Gorey. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxDataSources
import RxSwift
import RxCocoa

struct GGUser {
    let age:Int
    let name:String
}

class GGViewModel:NSObject {
    func getUsers() -> Observable<[SectionModel<String, GGUser>]>{
        return Observable.create({ (observer) -> Disposable in
            let users = [
                GGUser(age: 10, name: "Kitty"),
                GGUser(age: 15, name: "SnowPrinss"),
                GGUser(age: 20, name: "Gorey")
            ]
            let section = [SectionModel(model: "Users", items: users)]
            observer.onNext(section)
            observer.onCompleted()
            return Disposables.create{}
        })
    }
    
}


class RxDataSourceVC: UIViewController {
    
    let tableview = UITableView(frame: CGRect(x: 0, y: 0, width: R.kScreenW, height: R.kScreenH), style: .grouped)
    let cellId = "cellId"
    
    let ds = RxTableViewSectionedReloadDataSource<SectionModel<String, GGUser>>()
    let viewModel = GGViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        view.addSubview(tableview)
        
        ds.configureCell = { d, table, indexPath, user in
            let cell = table.dequeueReusableCell(withIdentifier: self.cellId)
            cell?.textLabel?.text = user.name
            return cell!
        }
        
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        viewModel.getUsers().bindTo(tableview.rx.items(dataSource: ds)).addDisposableTo(disposeBag)
        
    }
    
}


