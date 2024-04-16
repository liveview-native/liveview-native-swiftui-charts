//
//  AnyMark.swift
//
//
//  Created by Carson Katri on 6/13/23.
//

import Charts
import SwiftUI
import LiveViewNative

protocol MarkProtocol: ChartContent {}

/// A mark that displays x/y values.
protocol SimpleMark: MarkProtocol {
    init<X, Y>(
        element: ElementNode,
        x: PlottableValue<X>, y: PlottableValue<Y>
    ) where X : Plottable, Y : Plottable
}

/// A mark that displays a range along the x or y axis.
protocol RangeMark: MarkProtocol {
    init<X, Y>(
        element: ElementNode,
        xStart: PlottableValue<X>, xEnd: PlottableValue<X>, y: PlottableValue<Y>
    ) where X : Plottable, Y : Plottable
    init<X, Y>(
        element: ElementNode,
        x: PlottableValue<X>, yStart: PlottableValue<Y>, yEnd: PlottableValue<Y>
    ) where X : Plottable, Y : Plottable
}

/// A mark with a fixed interval and variable values.
protocol FixedRangeMark: MarkProtocol {
    init<Y>(
        element: ElementNode,
        xStart: CGFloat?, xEnd: CGFloat?, y: PlottableValue<Y>
    ) where Y : Plottable
    init<X>(
        element: ElementNode,
        x: PlottableValue<X>, yStart: CGFloat?, yEnd: CGFloat?
    ) where X : Plottable
}

/// A mark with a fixed interval and variable values.
protocol RangeFixedMark: MarkProtocol {
    init<X>(
        element: ElementNode,
        xStart: PlottableValue<X>, xEnd: PlottableValue<X>, y: CGFloat?
    ) where X : Plottable
    init<Y>(
        element: ElementNode,
        x: CGFloat?, yStart: PlottableValue<Y>, yEnd: PlottableValue<Y>
    ) where Y : Plottable
}

/// A mark that displays a range along the x and y axis.
protocol BidirectionalRangeMark: MarkProtocol {
    init<X, Y>(
        element: ElementNode,
        xStart: PlottableValue<X>, xEnd: PlottableValue<X>,
        yStart: PlottableValue<Y>, yEnd: PlottableValue<Y>
    ) where X : Plottable, Y : Plottable
}

/// A mark that displays a range along the x and y axis with one axis using a constant.
protocol FixedBidirectionalRangeMark: MarkProtocol {
    init<X>(
        element: ElementNode,
        xStart: PlottableValue<X>, xEnd: PlottableValue<X>,
        yStart: CGFloat?, yEnd: CGFloat?
    ) where X : Plottable
    
    init<Y>(
        element: ElementNode,
        xStart: CGFloat?, xEnd: CGFloat?,
        yStart: PlottableValue<Y>, yEnd: PlottableValue<Y>
    ) where Y : Plottable
}

/// A mark that displays x/y values and a series.
protocol SeriesMark: MarkProtocol {
    init<X, Y, S>(
        element: ElementNode,
        x: PlottableValue<X>, y: PlottableValue<Y>, series: PlottableValue<S>
    ) where X : Plottable, Y : Plottable, S : Plottable
}

/// A mark that displays range values and a series.
protocol RangeSeriesMark: MarkProtocol {
    init<X, Y, S>(
        element: ElementNode,
        xStart: PlottableValue<X>, xEnd: PlottableValue<X>, y: PlottableValue<Y>, series: PlottableValue<S>
    ) where X : Plottable, Y : Plottable, S : Plottable
    init<X, Y, S>(
        element: ElementNode,
        x: PlottableValue<X>, yStart: PlottableValue<Y>, yEnd: PlottableValue<Y>, series: PlottableValue<S>
    ) where X : Plottable, Y : Plottable, S : Plottable
}

/// A mark with fixed x or y values.
protocol FixedMark: MarkProtocol {
    init<X>(
        element: ElementNode,
        x: PlottableValue<X>, y: CGFloat?
    ) where X : Plottable
    init<Y>(
        element: ElementNode,
        x: CGFloat?, y: PlottableValue<Y>
    ) where Y : Plottable
}

/// A type that evaluates a mark given an element.
///
/// The mark is evaluated based on the attributes used, and its conformance to a refined `MarkProtocol`.
struct AnyMark<M: MarkProtocol>: ChartContent {
    let element: ElementNode
    
    var body: some ChartContent {
        let x = element.plottable(named: "x")
        let y = element.plottable(named: "y")
        
        let fixedX = element.attributeValue(for: "x")
            .flatMap(Double.init(_:))
            .flatMap(CGFloat.init(_:))
        let fixedY = element.attributeValue(for: "y")
            .flatMap(Double.init(_:))
            .flatMap(CGFloat.init(_:))
        
        let xStart = element.plottable(named: "xStart")
        let xEnd = element.plottable(named: "xEnd")
        
        let fixedXStart = element.attributeValue(for: "xStart")
            .flatMap(Double.init(_:))
            .flatMap(CGFloat.init(_:))
        let fixedXEnd = element.attributeValue(for: "xEnd")
            .flatMap(Double.init(_:))
            .flatMap(CGFloat.init(_:))
        
        let yStart = element.plottable(named: "yStart")
        let yEnd = element.plottable(named: "yEnd")
        
        let fixedYStart = element.attributeValue(for: "yStart")
            .flatMap(Double.init(_:))
            .flatMap(CGFloat.init(_:))
        let fixedYEnd = element.attributeValue(for: "yEnd")
            .flatMap(Double.init(_:))
            .flatMap(CGFloat.init(_:))
        
        let series = element.plottable(named: "series")
        
        if let x, let y, let series, let type = M.self as? any SeriesMark.Type {
            unbox(
                type,
                x: x.label, x.value,
                y: y.label, y.value,
                series: series.label, series.value
            )
        } else if let x, let y, let type = M.self as? any SimpleMark.Type {
            unbox(
                type,
                x: x.label, x.value,
                y: y.label, y.value
            )
        } else if let xStart, let xEnd, let y, let series, let type = M.self as? any RangeSeriesMark.Type {
            unbox(
                type,
                xStart: xStart.label, xStart.value,
                xEnd: xEnd.label, xEnd.value,
                y: y.label, y.value,
                series: series.label, series.value
            )
        } else if let xStart, let xEnd, let y, let type = M.self as? any RangeMark.Type {
            unbox(
                type,
                xStart: xStart.label, xStart.value,
                xEnd: xEnd.label, xEnd.value,
                y: y.label, y.value
            )
        } else if let yStart, let yEnd, let x, let series, let type = M.self as? any RangeSeriesMark.Type {
            unbox(
                type,
                x: x.label, x.value,
                yStart: yStart.label, yStart.value,
                yEnd: yEnd.label, yEnd.value,
                series: series.label, series.value
            )
        } else if let yStart, let yEnd, let x, let type = M.self as? any RangeMark.Type {
            unbox(
                type,
                x: x.label, x.value,
                yStart: yStart.label, yStart.value,
                yEnd: yEnd.label, yEnd.value
            )
        } else if let xStart, let xEnd, let yStart, let yEnd, let type = M.self as? any BidirectionalRangeMark.Type {
            unbox(
                type,
                xStart: xStart.label, xStart.value,
                xEnd: xEnd.label, xEnd.value,
                yStart: yStart.label, yStart.value,
                yEnd: yEnd.label, yEnd.value
            )
        } else if let x, let type = M.self as? any FixedMark.Type {
            unbox(
                type,
                x: x.label, x.value,
                y: fixedY
            )
        } else if let y, let type = M.self as? any FixedMark.Type {
            unbox(
                type,
                x: fixedX,
                y: y.label, y.value
            )
        } else if let xStart, let xEnd, let type = M.self as? any FixedBidirectionalRangeMark.Type {
            unbox(
                type,
                xStart: xStart.label, xStart.value,
                xEnd: xEnd.label, xEnd.value,
                yStart: fixedYStart,
                yEnd: fixedYEnd
            )
        } else if let yStart, let yEnd, let type = M.self as? any FixedBidirectionalRangeMark.Type {
            unbox(
                type,
                xStart: fixedXStart,
                xEnd: fixedXEnd,
                yStart: yStart.label, yStart.value,
                yEnd: yEnd.label, yEnd.value
            )
        } else if let xStart, let xEnd, let type = M.self as? any RangeFixedMark.Type {
            unbox(
                type,
                xStart: xStart.label, xStart.value,
                xEnd: xEnd.label, xEnd.value,
                y: fixedY
            )
        } else if let yStart, let yEnd, let type = M.self as? any RangeFixedMark.Type {
            unbox(
                type,
                x: fixedX,
                yStart: yStart.label, yStart.value,
                yEnd: yEnd.label, yEnd.value
            )
        } else if let x, let type = M.self as? any FixedRangeMark.Type {
            unbox(
                type,
                x: x.label, x.value,
                yStart: fixedYStart,
                yEnd: fixedYEnd
            )
        } else if let y, let type = M.self as? any FixedRangeMark.Type {
            unbox(
                type,
                xStart: fixedXStart,
                xEnd: fixedXEnd,
                y: y.label, y.value
            )
        }
    }
    
    // MARK: SimpleMark
    
    func unbox(
        _ type: (some SimpleMark).Type,
        x xLabel: String, _ x: some Plottable,
        y yLabel: String, _ y: some Plottable
    ) -> AnyChartContent {
        AnyChartContent(
            type.init(element: element, x: .value(xLabel, x), y: .value(yLabel, y))
        )
    }
    
    // MARK: SeriesMark
    
    func unbox(
        _ type: (some SeriesMark).Type,
        x xLabel: String, _ x: some Plottable,
        y yLabel: String, _ y: some Plottable,
        series seriesLabel: String, _ series: some Plottable
    ) -> AnyChartContent {
        AnyChartContent(
            type.init(element: element, x: .value(xLabel, x), y: .value(yLabel, y), series: .value(seriesLabel, series))
        )
    }
    
    // MARK: RangeMark
    
    func unbox<T: Plottable>(
        _ type: (some RangeMark).Type,
        xStart xStartLabel: String, _ xStart: T,
        xEnd xEndLabel: String, _ xEnd: some Plottable,
        y yLabel: String, _ y: some Plottable
    ) -> AnyChartContent {
        AnyChartContent(
            type.init(element: element, xStart: .value(xStartLabel, xStart), xEnd: .value(xEndLabel, xEnd as! T), y: .value(yLabel, y))
        )
    }
    
    func unbox<T: Plottable>(
        _ type: (some RangeMark).Type,
        x xLabel: String, _ x: some Plottable,
        yStart yStartLabel: String, _ yStart: T,
        yEnd yEndLabel: String, _ yEnd: some Plottable
    ) -> AnyChartContent {
        AnyChartContent(
            type.init(element: element, x: .value(xLabel, x), yStart: .value(yStartLabel, yStart), yEnd: .value(yEndLabel, yEnd as! T))
        )
    }
    
    // MARK: RangeSeriesMark
    
    func unbox<T: Plottable>(
        _ type: (some RangeSeriesMark).Type,
        xStart xStartLabel: String, _ xStart: T,
        xEnd xEndLabel: String, _ xEnd: some Plottable,
        y yLabel: String, _ y: some Plottable,
        series seriesLabel: String, _ series: some Plottable
    ) -> AnyChartContent {
        AnyChartContent(
            type.init(element: element, xStart: .value(xStartLabel, xStart), xEnd: .value(xEndLabel, xEnd as! T), y: .value(yLabel, y), series: .value(seriesLabel, series))
        )
    }
    
    func unbox<T: Plottable>(
        _ type: (some RangeSeriesMark).Type,
        x xLabel: String, _ x: some Plottable,
        yStart yStartLabel: String, _ yStart: T,
        yEnd yEndLabel: String, _ yEnd: some Plottable,
        series seriesLabel: String, _ series: some Plottable
    ) -> AnyChartContent {
        AnyChartContent(
            type.init(element: element, x: .value(xLabel, x), yStart: .value(yStartLabel, yStart), yEnd: .value(yEndLabel, yEnd as! T), series: .value(seriesLabel, series))
        )
    }
    
    // MARK: FixedMark
    
    func unbox(
        _ type: (some FixedMark).Type,
        x xLabel: String, _ x: some Plottable,
        y: CGFloat?
    ) -> AnyChartContent {
        AnyChartContent(
            type.init(element: element, x: .value(xLabel, x), y: y)
        )
    }
    
    func unbox(
        _ type: (some FixedMark).Type,
        x: CGFloat?,
        y yLabel: String, _ y: some Plottable
    ) -> AnyChartContent {
        AnyChartContent(
            type.init(element: element, x: x, y: .value(yLabel, y))
        )
    }
    
    // MARK: BidirectionalRangeMark
    
    func unbox<X: Plottable, Y: Plottable>(
        _ type: (some BidirectionalRangeMark).Type,
        xStart xStartLabel: String, _ xStart: X,
        xEnd xEndLabel: String, _ xEnd: some Plottable,
        yStart yStartLabel: String, _ yStart: Y,
        yEnd yEndLabel: String, _ yEnd: some Plottable
    ) -> AnyChartContent {
        AnyChartContent(
            type.init(element: element, xStart: .value(xStartLabel, xStart), xEnd: .value(xEndLabel, xEnd as! X), yStart: .value(yStartLabel, yStart), yEnd: .value(yEndLabel, yEnd as! Y))
        )
    }
    
    // MARK: FixedBidirectionalRangeMark
    
    func unbox<T: Plottable>(
        _ type: (some FixedBidirectionalRangeMark).Type,
        xStart xStartLabel: String, _ xStart: T,
        xEnd xEndLabel: String, _ xEnd: some Plottable,
        yStart: CGFloat?, yEnd: CGFloat?
    ) -> AnyChartContent {
        AnyChartContent(
            type.init(element: element, xStart: .value(xStartLabel, xStart), xEnd: .value(xEndLabel, xEnd as! T), yStart: yStart, yEnd: yEnd)
        )
    }
    
    func unbox<T: Plottable>(
        _ type: (some FixedBidirectionalRangeMark).Type,
        xStart: CGFloat?, xEnd: CGFloat?,
        yStart yStartLabel: String, _ yStart: T,
        yEnd yEndLabel: String, _ yEnd: some Plottable
    ) -> AnyChartContent {
        AnyChartContent(
            type.init(element: element, xStart: xStart, xEnd: xEnd, yStart: .value(yStartLabel, yStart), yEnd: .value(yEndLabel, yEnd as! T))
        )
    }
    
    // MARK: FixedRangeMark
    func unbox<T: Plottable>(
        _ type: (some RangeFixedMark).Type,
        xStart xStartLabel: String, _ xStart: T,
        xEnd xEndLabel: String, _ xEnd: some Plottable,
        y: CGFloat?
    ) -> AnyChartContent {
        AnyChartContent(
            type.init(element: element, xStart: .value(xStartLabel, xStart), xEnd: .value(xEndLabel, xEnd as! T), y: y)
        )
    }
    
    func unbox<T: Plottable>(
        _ type: (some RangeFixedMark).Type,
        x: CGFloat?,
        yStart yStartLabel: String, _ yStart: T,
        yEnd yEndLabel: String, _ yEnd: some Plottable
    ) -> AnyChartContent {
        AnyChartContent(
            type.init(element: element, x: x, yStart: .value(yStartLabel, yStart), yEnd: .value(yEndLabel, yEnd as! T))
        )
    }
    
    func unbox(
        _ type: (some FixedRangeMark).Type,
        xStart: CGFloat?,
        xEnd: CGFloat?,
        y yLabel: String, _ y: some Plottable
    ) -> AnyChartContent {
        AnyChartContent(
            type.init(element: element, xStart: xStart, xEnd: xEnd, y: .value(yLabel, y))
        )
    }
    
    func unbox(
        _ type: (some FixedRangeMark).Type,
        x xLabel: String, _ x: some Plottable,
        yStart: CGFloat?,
        yEnd: CGFloat?
    ) -> AnyChartContent {
        AnyChartContent(
            type.init(element: element, x: .value(xLabel, x), yStart: yStart, yEnd: yEnd)
        )
    }
}
