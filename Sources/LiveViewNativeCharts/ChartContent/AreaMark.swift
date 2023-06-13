//
//  AreaMark.swift
//
//
//  Created by Carson Katri on 6/13/23.
//

import Charts
import LiveViewNative

extension AreaMark: SimpleMark {
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
