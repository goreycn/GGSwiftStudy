//
//  UserViewModel.swift
//  GGSwiftStudy
//
//  Created by Gorey on 16/10/12.
//  Copyright © 2016年 Gorey. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

class UserViewModel: NSObject {
    
    func getUsers() -> Observable<[SectionModel<String, User>]>{
        
        return Observable.create{ (observer) -> Disposable in
            
            let users = [
                User(screenName:"Demo"),
                User(screenName:"Demo2")
            ]
            
            let section = [SectionModel(model: "", items: users)]
            
            observer.onNext(section)
            
            observer.onCompleted()
            
            return Disposables.create{}
        }
        
    }
    
}