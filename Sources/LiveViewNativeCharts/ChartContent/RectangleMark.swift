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
///   x:label="Positive"
///   x:value={item.positive}
///
///   y:label="Negative"
///   y:value={item.negative}
///
///   class="fg-number"
///   number={item.num}
/// />
/// ```
///
/// ```elixir
/// ~SHEET"""
/// "fg-number" do
///   foregroundStyle(by: .value("Number", attr("number")))
/// end
/// """
/// ```
///
/// Provide an `xStart`/`xEnd` and `yStart`/`yEnd` to manually specify the area to fill.
///
/// ```html
/// <RectangleMark
///   xStart:label="Rect Start Width"
///   xStart:value={item.x - 0.25}
///   xEnd:label="Rect End Width"
///   xEnd:value={item.x + 0.25}
///   yStart:label="Rect Start Height"
///   yStart:value={item.y - 0.25}
///   yEnd:label="Rect End Height"
///   yEnd:value={item.y + 0.2}
///
///   class="fg-blue"
/// />
///
/// <PointMark
///   x:label="X"
///   x:value={item.x}
///   y:label="Y"
///   y:value={item.y}
/// />
/// ```
///
/// ## Attributes
/// * `x`
/// * `y`
/// * `xStart`
/// * `xEnd`
/// * `yStart`
/// * `yEnd`
/// * `width` - The rectangle width as a ``LiveViewNativeCharts/Charts/MarkDimension``
/// * `height` - The rectangle height as a ``LiveViewNativeCharts/Charts/MarkDimension``
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
extension RectangleMark: SimpleMark {
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
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
