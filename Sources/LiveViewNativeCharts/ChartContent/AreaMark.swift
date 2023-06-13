//
//  AreaMark.swift
//
//
//  Created by Carson Katri on 6/13/23.
//

import Charts
import LiveViewNative

/// A mark that displays a filled region.
///
/// By default, the area underneath a line plotting the `x` and `y` attributes will be filled.
///
/// ```html
/// <AreaMark
///   x={item.date}
///   x:label="Date"
///
///   y={item.profit}
///   y:label="Profit"
/// />
/// ```
///
/// An area can also be filled given a start and end along the x or y axis.
/// Only the area within the start and end points will be filled.
///
/// ```html
/// <AreaMark
///   x={item.time}
///   x:label="Time"
///
///   y-start={item.low}
///   y-start:label="Low Temperature"
///   y-end={item.high}
///   y-end:label="High Temperature"
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
/// * `series`
/// * `stacking` - The ``LiveViewNativeCharts/Charts/MarkStackingMethod``
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
extension AreaMark: SimpleMark {
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    init<X, Y>(element: ElementNode, x: PlottableValue<X>, y: PlottableValue<Y>) where X : Plottable, Y : Plottable {
        self.init(x: x, y: y, stacking: (try? element.attribute(named: "stacking").flatMap(MarkStackingMethod.init)) ?? .standard)
    }
}

extension AreaMark: RangeMark {
    init<X, Y>(element: ElementNode, xStart: PlottableValue<X>, xEnd: PlottableValue<X>, y: PlottableValue<Y>) where X : Plottable, Y : Plottable {
        self.init(xStart: xStart, xEnd: xEnd, y: y)
    }
    
    init<X, Y>(element: ElementNode, x: PlottableValue<X>, yStart: PlottableValue<Y>, yEnd: PlottableValue<Y>) where X : Plottable, Y : Plottable {
        self.init(x: x, yStart: yStart, yEnd: yEnd)
    }
}

extension AreaMark: SeriesMark {
    init<X, Y, S>(element: ElementNode, x: PlottableValue<X>, y: PlottableValue<Y>, series: PlottableValue<S>) where X : Plottable, Y : Plottable, S : Plottable {
        self.init(x: x, y: y, series: series, stacking: (try? element.attribute(named: "stacking").flatMap(MarkStackingMethod.init)) ?? .standard)
    }
}

extension AreaMark: RangeSeriesMark {
    init<X, Y, S>(element: ElementNode, xStart: PlottableValue<X>, xEnd: PlottableValue<X>, y: PlottableValue<Y>, series: PlottableValue<S>) where X : Plottable, Y : Plottable, S : Plottable {
        self.init(xStart: xStart, xEnd: xEnd, y: y, series: series)
    }
    
    init<X, Y, S>(element: ElementNode, x: PlottableValue<X>, yStart: PlottableValue<Y>, yEnd: PlottableValue<Y>, series: PlottableValue<S>) where X : Plottable, Y : Plottable, S : Plottable {
        self.init(x: x, yStart: yStart, yEnd: yEnd, series: series)
    }
}
