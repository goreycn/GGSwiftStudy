//
//  RxSwiftStudyVC.swift
//  GGSwiftStudy
//
//  Created by Gorey on 16/10/14.
//  Copyright © 2016年 Gorey. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import SwiftyJSON
import RxDataSources
import Kingfisher

class RxSwiftStudyVC : UITableViewController {
    
    var demos = Array<JSON>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "Gank"
        
        loadData()
        
    }
    
    func loadData(){
        
        let provider = RxMoyaProvider<GankService>()
        provider.request(.Fuli(page: 1))
            .map({ (resp) -> JSON in
                let json = JSON(data: resp.data)
                return json
            })
            .filter({ (json) -> Bool in
                
                let error = json["error"].bool ?? false
                let count = json["count"].number ?? 0
                
                if error == false && count.intValue > 0 {
                    return true
                }
                else {
                    return false
                }
                
            })
            .subscribeNext({ (json) in
                if let results = json["results"].array {
                    
                    self.demos.removeAll()
                    results.forEach({ (line) in
                        self.demos.append(line)
                    })
                    self.tableView.reloadData()
                }
            })
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        let j = demos[indexPath.row]
        let desc = j["desc"].string ?? "-"
        let img = j["url"].string ?? ""
        cell.textLabel?.text = desc
        cell.imageView?.kf.setImage(with: URL(string: img))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
