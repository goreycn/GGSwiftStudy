//
//  GankService.swift
//  GGSwiftStudy
//
//  Created by Gorey on 16/10/17.
//  Copyright © 2016年 Gorey. All rights reserved.
//

import Foundation
import Moya

// 面向action调用的接口服务
enum GankService {
    case Fuli(page:Int)
}


// 基本配置信息
extension GankService: TargetType {
    var baseURL: URL { return URL(string: "http://gank.io/")! }
    var path: String {
        switch self {
        case .Fuli(page:let pageIndex):
            return "api/search/query/listview/category/福利/count/10/page/\(pageIndex)"
        }
    }
    var method: Moya.Method {
        switch self {
        case .Fuli(page: _):
            return .get
        }
    }
    var parameters: [String: Any]? {
        return nil
    }
    var sampleData: Data {
        switch self {
        case .Fuli(page: _):
            return "{\"count\":10,\"error\":false,\"results\":[{\"desc\":\"10.27\",\"ganhuo_id\":\"56cc6d1d421aa95caa70755f\",\"publishedAt\":\"2015-10-27T02:43:16.906000\",\"readability\":\"\",\"type\":\"A\",\"url\":\"http://ww2.sinaimg.cn/large/7a8aed7bjw1exfffnlf2gj20hq0qoju9.jpg\",\"who\":\"User\"}}".utf8EncodedData
        }
    }
    var task: Task {
        return .request
    }
}


// MARK: - Helpers
private extension String {
    var urlEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8EncodedData: Data {
        return self.data(using: .utf8)!
    }
}
