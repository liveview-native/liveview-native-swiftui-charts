//
//  RectangleMark.swift
//
//
//  Created by Carson Katri on 6/13/23.
//

import Charts
import SwiftUI
import LiveViewNative

/// A mark that fills a rectangular area.
///
/// Provide an `x` and `y` position to fill an area with a rectangle.
///
/// ```html
/// <RectangleMark
///   x={item.positive}
///   x:label="Positive"
///
///   y={item.negative}
///   y:label="Negative"
///
///   modifiers={@native |> foreground_style(value: {"Number", item.num})}
/// />
/// ```
///
/// Provide an `x-start`/`x-end` and `y-start`/`y-end` to manually specify the area to fill.
///
/// ```html
/// <RectangleMark
///   x-start={item.x - 0.25}
///   x-start:label="Rect Start Width"
///   x-end={item.x + 0.25}
///   x-end:label="Rect End Width"
///   y-start={item.y - 0.25}
///   y-start:label="Rect Start Height"
///   y-end={item.y + 0.2}
///   y-end:label="Rect End Height"
///
///   modifiers={@native |> foreground_style(primary: {:color, :blue, [{:opacity, 0.5}]})}
/// />
///
/// <PointMark
///   x={item.x}
///   x:label="X"
///   y={item.y}
///   y:label="Y"
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
/// * `width` - The rectangle width as a ``LiveViewNativeCharts/Charts/MarkDimension``
/// * `height` - The rectangle height as a ``LiveViewNativeCharts/Charts/MarkDimension``
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
extension RectangleMark: SimpleMark {
    init<X, Y>(element: ElementNode, x: PlottableValue<X>, y: PlottableValue<Y>) where X : Plottable, Y : Plottable {
        self.init(x: x, y: y)
    }
}

extension RectangleMark: RangeMark {
    init<X, Y>(element: ElementNode, xStart: PlottableValue<X>, xEnd: PlottableValue<X>, y: PlottableValue<Y>) where X : Plottable, Y : Plottable {
        self.init(
            xStart: xStart,
            xEnd: xEnd,
            y: y,
            height: (try? element.attribute(named: "height").flatMap(MarkDimension.init)) ?? .automatic
        )
    }

    init<X, Y>(element: ElementNode, x: PlottableValue<X>, yStart: PlottableValue<Y>, yEnd: PlottableValue<Y>) where X : Plottable, Y : Plottable {
        self.init(
            x: x,
            yStart: yStart,
            yEnd: yEnd,
            width: (try? element.attribute(named: "width").flatMap(MarkDimension.init)) ?? .automatic
        )
    }
}

extension RectangleMark: FixedRangeMark {
    init<Y>(element: ElementNode, xStart: CGFloat?, xEnd: CGFloat?, y: PlottableValue<Y>) where Y : Plottable {
        self.init(
            xStart: xStart,
            xEnd: xEnd,
            y: y,
            height: (try? element.attribute(named: "height").flatMap(MarkDimension.init)) ?? .automatic
        )
    }
    
    init<X>(element: ElementNode, x: PlottableValue<X>, yStart: CGFloat?, yEnd: CGFloat?) where X : Plottable {
        self.init(
            x: x,
            yStart: yStart,
            yEnd: yEnd,
            width: (try? element.attribute(named: "width").flatMap(MarkDimension.init)) ?? .automatic
        )
    }
}

extension RectangleMark: BidirectionalRangeMark {
    init<X, Y>(element: ElementNode, xStart: PlottableValue<X>, xEnd: PlottableValue<X>, yStart: PlottableValue<Y>, yEnd: PlottableValue<Y>) where X : Plottable, Y : Plottable {
        self.init(
            xStart: xStart,
            xEnd: xEnd,
            yStart: yStart,
            yEnd: yEnd
        )
    }
}

extension RectangleMark: FixedBidirectionalRangeMark {
    init<X>(element: LiveViewNative.ElementNode, xStart: PlottableValue<X>, xEnd: PlottableValue<X>, yStart: CGFloat?, yEnd: CGFloat?) where X : Plottable {
        self.init(
            xStart: xStart,
            xEnd: xEnd,
            yStart: yStart,
            yEnd: yEnd
        )
    }

    init<Y>(element: LiveViewNative.ElementNode, xStart: CGFloat?, xEnd: CGFloat?, yStart: PlottableValue<Y>, yEnd: PlottableValue<Y>) where Y : Plottable {
        self.init(
            xStart: xStart,
            xEnd: xEnd,
            yStart: yStart,
            yEnd: yEnd
        )
    }
}
