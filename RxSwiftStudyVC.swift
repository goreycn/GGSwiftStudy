//
//  RxSwiftStudyVC.swift
//  GGSwiftStudy
//
//  Created by Gorey on 16/10/14.
//  Copyright © 2016年 Gorey. All rights reserved.
//

import Foundation
import RxSwift

class RxSwiftStudyVC : UITableViewController {
    
    let demos = [
        "String取值"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "RxSwfit Study"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = demos[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        switch indexPath.row {
        case 0:
            Observable<String>.from(["one", "two"]).subscribe{
                e in
                if let str = e.element {
                    debugPrint(str)
                }
            }

        default:
            debugPrint(demos[indexPath.row])
        }
    }
}
