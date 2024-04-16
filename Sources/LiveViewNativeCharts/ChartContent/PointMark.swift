//
//  PointMark.swift
//
//
//  Created by Carson Katri on 6/13/23.
//

import Charts
import SwiftUI
import LiveViewNative

/// A mark that displays discrete points.
///
/// ```html
/// <PointMark
///   x:label="Date"
///   x:value={item.date}
///
///   y:label="Profit"
///   y:value={item.profit}
/// />
/// ```
///
/// Only provide the `x` or `y` attribute to create a 1D list of points.
///
/// ## Attributes
/// * `x`
/// * `y`
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
extension PointMark: SimpleMark {
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
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
