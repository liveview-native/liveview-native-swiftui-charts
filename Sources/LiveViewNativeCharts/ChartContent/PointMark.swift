//
//  PointMark.swift
//
//
//  Created by Carson Katri on 6/13/23.
//

import Charts
import SwiftUI
import LiveViewNative

extension PointMark: SimpleMark {
    init<X, Y>(element: ElementNode, x: PlottableValue<X>, y: PlottableValue<Y>) where X : Plottable, Y : Plottable {
        self.init(x: x, y: y)
    }
}

extension PointMark: FixedMark {
    init<X>(element: ElementNode, x: PlottableValue<X>, y: CGFloat?) where X : Plottable {
        self.init(x: x, y: y)
    }
    
    init<Y>(element: ElementNode, x: CGFloat?, y: PlottableValue<Y>) where Y : Plottable {
        self.init(x: x, y: y)
    }
}
