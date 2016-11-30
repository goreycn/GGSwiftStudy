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
import MJRefresh
import SVProgressHUD

class RxSwiftStudyVC : UITableViewController {
    
    var demos = Array<JSON>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "Gank"
        
        tableView.register(MeiziCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView(frame: CGRect.zero)

        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { 
            self.loadData()
        })
        
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { 
            if self.demos.count % 10 == 0 {
                self.loadData(self.demos.count / 10 + 1)
            }
            else {
                self.tableView.mj_footer.endRefreshingWithNoMoreData()
            }
        })
        
        loadData()
    }
    
    func loadData(_ index:Int = 1){
        
        
        // 转入 参数 和 header 方法
/*
        let endpointClosure = { (target: GankService) -> Endpoint<GankService> in
            let url = target.baseURL.appendingPathComponent(target.path).absoluteString
            return Endpoint(URL: url,
                            sampleResponseClosure: {.networkResponse(200, target.sampleData)},
                            method: target.method,
                            parameters: ["username":"name", "password":self."pwd"],
                            httpHeaderFields:["Request-Source":"4","Response-Type":"text/json","version":"v_1_0"])
        }
        
        let provider = RxMoyaProvider<GankService>(endpointClosure:endpointClosure)
*/
       
        let provider = RxMoyaProvider<GankService>()
        
        _ = provider.request(.Fuli(page: index))
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
            .subscribe(onNext: { (json) in
                if let results = json["results"].array {
                    
                    if index == 1 {
                        self.demos.removeAll()
                    }
                    
                    results.forEach({ (line) in
                        self.demos.append(line)
                    })
                    self.tableView.reloadData()
                }

                }, onError: { (error) in
                    
                }, onCompleted: { 
                    self.tableView.mj_header.endRefreshing()
                                   self.tableView.mj_footer.endRefreshing()
                }, onDisposed: { 

            })

        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? MeiziCell ?? MeiziCell(style: .default, reuseIdentifier: "cell")
        
        let j = demos[indexPath.row]
        cell.updateWith(j: j)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
}


class MeiziCell : UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        contentView.addSubview(ivAvatar)
        ivAvatar.snp.makeConstraints { (m) in
            m.left.equalTo(contentView)
            m.top.equalTo(contentView).offset(5)
            m.right.equalTo(contentView)
            m.height.equalTo(400)
        }
        
        contentView.addSubview(lbDesc)
        lbDesc.snp.makeConstraints { (m) in
            m.left.equalTo(contentView).offset(5)
            m.top.equalTo(self.ivAvatar.snp.bottom).offset(5)
            m.right.equalTo(contentView).offset(5)
            m.bottom.equalTo(contentView).offset(-5)
        }
        
        lbDesc.preferredMaxLayoutWidth = UIScreen.main.bounds.size.width - 10
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var ivAvatar : UIImageView = {
        let a = UIImageView()
        a.contentMode = .scaleAspectFill
        a.clipsToBounds = true
        return a
    }()
    
    lazy var lbDesc : UILabel = {
        let a = UILabel()
        a.numberOfLines = 0
        return a
    }()
    
    func updateWith(j:JSON) {
        let desc = j["desc"].string ?? "-"
        let img = j["url"].string ?? ""
        lbDesc.text = desc
        ivAvatar.kf.setImage(with: URL(string: img))
    }
}
