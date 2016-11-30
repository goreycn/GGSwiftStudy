//
// Created by Gorey on 16/11/16.
// Copyright (c) 2016 Gorey. All rights reserved.
//

import Foundation
import SnapKit

public extension ConstraintMaker {

    public var l: ConstraintMakerExtendable {
        return self.left
    }

    public var r: ConstraintMakerExtendable {
        return self.right
    }

    public var t: ConstraintMakerExtendable {
        return self.top
    }

    public var b: ConstraintMakerExtendable {
        return self.bottom
    }

    public var w: ConstraintMakerExtendable {
        return self.width
    }

    public var h: ConstraintMakerExtendable {
        return self.height
    }

    public var cx: ConstraintMakerExtendable {
        return self.centerX
    }

    public var cy: ConstraintMakerExtendable {
        return self.centerY
    }

    public var c: ConstraintMakerExtendable {
        return self.center
    }

    // 相对于另外一个视图的 左 边对齐, offset: 偏移量
    public func l( _ other: ConstraintRelatableTarget, _ offset: ConstraintOffsetTarget = 0 ) -> ConstraintMaker {
        self.left.equalTo( other ).offset( offset )
        return self
    }
    // 相对于另外一个视图的 右 边对齐, offset: 偏移量
    public func r( _ other: ConstraintRelatableTarget, _ offset: ConstraintOffsetTarget = 0 ) -> ConstraintMaker {
        self.right.equalTo( other ).offset( offset )
        return self
    }
    // 相对于另外一个视图的 上 边对齐, offset: 偏移量
    public func t( _ other: ConstraintRelatableTarget, _ offset: ConstraintOffsetTarget = 0 ) -> ConstraintMaker {
        self.top.equalTo( other ).offset( offset )
        return self
    }
    // 相对于另外一个视图的 底 边对齐, offset: 偏移量
    public func b( _ other: ConstraintRelatableTarget, _ offset: ConstraintOffsetTarget = 0 ) -> ConstraintMaker {
        self.bottom.equalTo( other ).offset( offset )
        return self
    }
    // 相对于另外一个视图的 宽 边对齐, offset: 偏移量
    public func w( _ other: ConstraintRelatableTarget, _ offset: ConstraintOffsetTarget = 0 ) -> ConstraintMaker {
        self.width.equalTo( other ).offset( offset )
        return self
    }
    // 相对于另外一个视图的 高 边对齐, offset: 偏移量
    public func h( _ other: ConstraintRelatableTarget, _ offset: ConstraintOffsetTarget = 0 ) {
        if other is Int {
            self.height.equalTo( other )
        } else if other is UInt {
            self.height.equalTo( other )
        } else if other is Float {
            self.height.equalTo( other )
        } else if other is Double {
            self.height.equalTo( other )
        } else if other is CGFloat {
            self.height.equalTo( other )
        } else {
            self.height.equalTo( other ).offset( offset )
        }

    }
    // 相对于另外一个视图的 中心点x 边对齐, offset: 偏移量
    public func cx( _ other: ConstraintRelatableTarget, _ offset: ConstraintOffsetTarget = 0 ) -> ConstraintMaker {
        self.centerX.equalTo( other ).offset( offset )
        return self
    }
    // 相对于另外一个视图的 中心点y 边对齐, offset: 偏移量
    public func cy( _ other: ConstraintRelatableTarget, _ offset: ConstraintOffsetTarget = 0 ) -> ConstraintMaker {
        self.centerY.equalTo( other ).offset( offset )
        return self
    }

    // 与父视图左边距对齐,  offset: 偏移量
    public func pl( _ offset: ConstraintOffsetTarget = 0 ) -> ConstraintMaker {
        _ = self.l.es( offset )
        return self
    }
    // 与父视图右边距对齐,  offset: 偏移量
    public func pr( _ offset: ConstraintOffsetTarget = 0 ) -> ConstraintMaker {
        _ = self.r.es( offset )
        return self
    }
    // 与父视图顶边距对齐,  offset: 偏移量
    public func pt( _ offset: ConstraintOffsetTarget = 0 ) -> ConstraintMaker {
        _ = self.t.es( offset )
        return self
    }
    // 与父视图底边距对齐,  offset: 偏移量
    public func pb( _ offset: ConstraintOffsetTarget = 0 ) -> ConstraintMaker {
        _ = self.b.es( offset )
        return self
    }
    // 与父视图宽度相等, offset: 偏移量
    public func pw( _ offset: ConstraintOffsetTarget = 0 ) -> ConstraintMaker {
        _ = self.w.es( offset )
        return self
    }
    // 与父视图高度相等, offset: 偏移量
    public func ph( _ offset: ConstraintOffsetTarget = 0 ) -> ConstraintMaker {
        _ = self.h.es( offset )
        return self
    }
    // 与父视图中心点x相等, offset: 偏移量
    public func pcx( _ offset: ConstraintOffsetTarget = 0 ) -> ConstraintMaker {
        _ = self.cx.es( offset )
        return self
    }
    // 与父视图中心点y相等, offset: 偏移量
    public func pcy( _ offset: ConstraintOffsetTarget = 0 ) -> ConstraintMaker {
        _ = self.cy.es( offset )
        return self
    }

}

public extension ConstraintViewDSL {

    public func mc( _ closure: ( _ make: ConstraintMaker ) -> Void ) {
        self.makeConstraints( closure )
    }

    public func rc( _ closure: ( _ make: ConstraintMaker ) -> Void ) {
        self.remakeConstraints( closure )
    }

    public func uc( _ closure: ( _ make: ConstraintMaker ) -> Void ) {
        self.updateConstraints( closure )
    }

}

public extension ConstraintMakerRelatable {

    @discardableResult
    public func e( _ other: ConstraintRelatableTarget, _ offset: ConstraintOffsetTarget = 0, _ file: String = #file, _ line: UInt = #line ) -> ConstraintMakerEditable {

        if other is Int {
            return self.equalTo( other )
        } else if other is UInt {
            return self.equalTo( other )
        } else if other is Float {
            return self.equalTo( other )
        } else if other is Double {
            return self.equalTo( other )
        } else if other is CGFloat {
            return self.equalTo( other )
        } else {
            return self.equalTo( other ).offset( offset )
        }
    }

    @discardableResult
    public func ee( _ other: ConstraintRelatableTarget, _ file: String = #file, _ line: UInt = #line ) -> ConstraintMakerEditable {
        return self.equalTo( other )
    }

    @discardableResult
    public func le( _ other: ConstraintRelatableTarget, _ offset: ConstraintOffsetTarget = 0, _ file: String = #file, _ line: UInt = #line ) -> ConstraintMakerEditable {
        return self.lessThanOrEqualTo( other ).offset( offset )
    }

    @discardableResult
    public func ge( _ other: ConstraintRelatableTarget, _ offset: ConstraintOffsetTarget = 0, _ file: String = #file, _ line: UInt = #line ) -> ConstraintMakerEditable {
        return self.greaterThanOrEqualTo( other ).offset( offset )
    }

    // 等于父视图
    public func es( _ offset: ConstraintOffsetTarget = 0, _ file: String = #file, _ line: UInt = #line ) -> ConstraintMakerEditable {
        return self.equalToSuperview().offset( offset )
    }

}

public extension ConstraintView {

    public func mc( _ closure: ( _ make: ConstraintMaker ) -> Void ) {
        self.snp.makeConstraints( closure )
    }

    public func mu( _ closure: ( _ make: ConstraintMaker ) -> Void ) {
        self.snp.updateConstraints( closure )
    }

    public func mr( _ closure: ( _ make: ConstraintMaker ) -> Void ) {
        self.snp.remakeConstraints( closure )
    }

    public var l: ConstraintItem {
        get {
            return self.snp.left
        }
    }
    public var r: ConstraintItem {
        get {
            return self.snp.right
        }
    }
    public var t: ConstraintItem {
        get {
            return self.snp.top
        }
    }
    public var b: ConstraintItem {
        get {
            return self.snp.bottom
        }
    }
}

