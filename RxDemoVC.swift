//
// Created by Gorey on 16/11/15.
// Copyright (c) 2016 Gorey. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit
import RxDataSources

class RxDemoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


        view.addSubview( tfName )
        view.addSubview( tfPwd )
        view.addSubview( lbResult )
        view.addSubview( btnDone )


//        tfName.snp.makeConstraints {
//            m in m.left.equalTo( self.view ).offset( 20 )
//            m.right.equalTo( self.view ).offset( -20 )
//            m.top.equalTo( self.view ).offset( 100 )
//            m.height.equalTo( 40 )
//        }

//        tfName.snp.makeConstraints {
//            m in
//            m.l.e(self.view, 20)
//            m.r.e(self.view, -20)
//            m.t.e(self.view, 100)
//            m.h.e(40)
//        }


//        tfName.snp.mc {
//            m in
//            m.l.es(20)
//            m.r.es(-20)
//            m.t.es(100)
//            m.h.e(40)
//        }

//        tfName.snp.mc {
//            m in
//            m.l.es(20)
//            m.r.es(-20)
//            m.t.es(100)
//            m.h.e(40)
//        }

//        tfName.mc {
//            m in
//            m.pl(20)
//            m.pr(-20)
//            m.pt(100)
//            m.h(40)
//        }

        tfName.mc {
            $0.pl(20).pr(-20).pt(100).h(40)
        }

        tfPwd.mc {
            m in
            m.l(self.tfName).r(self.tfName).t(self.tfName.b, 10).h(40)
        }

        lbResult.mc {
            $0.l(self.tfPwd).r(self.tfPwd).t(self.tfPwd.b, 10).h(40)
        }

        btnDone.mc {
            $0.pcx().pw( -50 ).h( 40 ).t( self.lbResult.b, 20 )
        }

        view.backgroundColor = R.color.bg

        // 绑定两个数据源, 实时输出到 另外一个输出
        Observable.combineLatest( tfName.rx.text, tfPwd.rx.text ) {
            a, b in "\( a! ) \( b! )"
        }.bindTo( self.lbResult.rx.text )

        // 点击效果
//        self.btnDone.rx.tap.subscribeNext {
//            debugPrint("Tap")
//        }
    }

    lazy var tfName: UITextField = {
        let a = UITextField()
        a.borderStyle = .roundedRect
        return a
    }()

    lazy var tfPwd: UITextField = {
        let a = UITextField()
        a.borderStyle = .roundedRect
        return a
    }()

    lazy var lbResult: UILabel = {
        let a = UILabel()
        return a
    }()

    lazy var btnDone: UIButton = {
        let a = UIButton(type: .custom)
        a.setTitle("点我", for: [])
        a.setTitleColor(R.color.red, for: [])
        a.backgroundColor = R.color.white
        return a
    }()
}
