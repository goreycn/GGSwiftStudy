//
//  AppDelegate.swift
//  GGSwiftStudy
//
//  Created by Gorey on 16/10/12.
//  Copyright © 2016年 Gorey. All rights reserved.
//

import UIKit
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: MenuVC())
        
        _ = myJust(element: 0).subscribe(onNext: { n in
            debugPrint(n)
        })
        
        return true
    }
    
    
    func myJust<E>(element: E) -> Observable<E> {
        return Observable.create({ (observer) -> Disposable in
            observer.on(.next(element))
            observer.on(.completed)
            return Disposables.create()
        })
    }
    
}

