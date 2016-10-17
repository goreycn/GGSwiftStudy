//
//  GankResponeExt.swift
//  GGSwiftStudy
//
//  Created by Gorey on 16/10/17.
//  Copyright © 2016年 Gorey. All rights reserved.
//

import Foundation
import Moya
import RxSwift

extension ObservableType where E == Response {

    public func filterGank() -> RxSwift.Observable<Moya.Response> {
        return flatMap { response -> Observable<E> in
            return Observable.just(response)
        }
    }
    
}

