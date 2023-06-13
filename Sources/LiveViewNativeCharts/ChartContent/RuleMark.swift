//
//  RuleMark.swift
//
//
//  Created by Carson Katri on 6/13/23.
//

import Charts
import SwiftUI
import LiveViewNative

/// A mark that draws a horizontal or vertical line.
///
/// Create a horizontal line by providing the `y` attribute, and optionally an `x-start`/`x-end`.
///
/// ```html
/// <RuleMark
///   y={5.8}
///   y:label="Minimum Height"
/// />
/// ```
///
/// Create a vertical line by providing the `x` attribute, and optionally a `y-start`/`y-end`.
///
/// ```html
/// <RuleMark
///   x={2.5}
///   x:label="Start Time"
///
///   y-start={1}
///   y-start:label="Start of Week"
///   y-end={5}
///   y-end:label="End of Week"
/// />
/// ```
///
/// ## Attributes
/// * `x`
/// * `y`
/// * `x-start`
/// * `x-end`
/// * `y-start`
/// * `y-end`
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
extension RuleMark: RangeMark {
    init<X, Y>(element: ElementNode, xStart: PlottableValue<X>, xEnd: PlottableValue<X>, y: PlottableValue<Y>) where X : Plottable, Y : Plottable {
        self.init(xStart: xStart, xEnd: xEnd, y: y)
    }
    
    init<X, Y>(element: ElementNode, x: PlottableValue<X>, yStart: PlottableValue<Y>, yEnd: PlottableValue<Y>) where X : Plottable, Y : Plottable {
        self.init(x: x, yStart: yStart, yEnd: yEnd)
    }
}

extension RuleMark: FixedRangeMark {
    init<Y>(element: ElementNode, xStart: CGFloat?, xEnd: CGFloat?, y: PlottableValue<Y>) where Y : Plottable {
        self.init(xStart: xStart, xEnd: xEnd, y: y)
    }
    
    init<X>(element: ElementNode, x: PlottableValue<X>, yStart: CGFloat?, yEnd: CGFloat?) where X : Plottable {
        self.init(x: x, yStart: yStart, yEnd: yEnd)
    }
}

extension RuleMark: RangeFixedMark {
    init<X>(element: ElementNode, xStart: PlottableValue<X>, xEnd: PlottableValue<X>, y: CGFloat?) where X : Plottable {
        self.init(xStart: xStart, xEnd: xEnd, y: y)
    }
    
    init<Y>(element: ElementNode, x: CGFloat?, yStart: PlottableValue<Y>, yEnd: PlottableValue<Y>) where Y : Plottable {
        self.init(x: x, yStart: yStart, yEnd: yEnd)
    }
}
