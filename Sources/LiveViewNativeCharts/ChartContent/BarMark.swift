//
//  BarMark.swift
//
//
//  Created by Carson Katri on 6/13/23.
//

import Charts
import SwiftUI
import LiveViewNative

/// A mark that displays a vertical or horizontal bar.
///
/// Use the `x` and `y` attributes to create a simple vertical bar.
///
/// ```html
/// <BarMark
///   x:label="Date"
///   x:value={item.date}
///
///   y:label="Profit"
///   y:value={item.profit}
/// />
/// ```
///
/// Provide only the `x` or `y` attribute with a label to create a stacked 1D bar.
///
/// - Note: If a label is not provided, a value is assumed to be a fixed size.
///
/// ```html
/// <BarMark
///   x:label="Profit"
///   x:value={item.profit}
///
///   class="fg-product"
///   product={item.product}
/// />
/// ```
///
/// ```elixir
/// ~SHEET"""
/// "fg-product" do
///   foregroundStyle(by: .value("Product", attr("product")))
/// end
/// ```
///
/// - Note: The example above uses the ``ForegroundStyleModifier`` modifier to represent categories with colors.
///
/// Use the `xStart`/`xEnd` or `yStart`/`yEnd` attributes to create an interval bar.
///
/// ```html
/// <BarMark
///   xStart:label="Start Time"
///   xStart:value={item.start}
///
///   xEnd:label="End Time"
///   xEnd:value={item.end}
///
///   y:label="Job"
///   y:value={item.job}
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
/// * `width` - The bar width as a ``LiveViewNativeCharts/Charts/MarkDimension``
/// * `height` - The bar height as a ``LiveViewNativeCharts/Charts/MarkDimension``
/// * `stacking` - The ``LiveViewNativeCharts/Charts/MarkStackingMethod``
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
extension BarMark: SimpleMark {
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    init<X, Y>(element: ElementNode, x: PlottableValue<X>, y: PlottableValue<Y>) where X : Plottable, Y : Plottable {
        self.init(
            x: x,
            y: y,
            width: (try? element.attributeValue(MarkDimension.self, for: "width")) ?? .automatic,
            height: (try? element.attributeValue(MarkDimension.self, for: "height")) ?? .automatic,
            stacking: (try? element.attributeValue(MarkStackingMethod.self, for: "stacking")) ?? .standard
        )
    }
}

extension BarMark: RangeMark {
    init<X, Y>(element: ElementNode, x: PlottableValue<X>, yStart: PlottableValue<Y>, yEnd: PlottableValue<Y>) where X : Plottable, Y : Plottable {
        self.init(
            x: x,
            yStart: yStart,
            yEnd: yEnd,
            width: (try? element.attributeValue(MarkDimension.self, for: "width")) ?? .automatic
        )
    }
    
    init<X, Y>(element: ElementNode, xStart: PlottableValue<X>, xEnd: PlottableValue<X>, y: PlottableValue<Y>) where X : Plottable, Y : Plottable {
        self.init(
            xStart: xStart,
            xEnd: xEnd,
            y: y,
            height: (try? element.attributeValue(MarkDimension.self, for: "height")) ?? .automatic
        )
    }
}

extension BarMark: FixedRangeMark {
    init<X>(element: ElementNode, x: PlottableValue<X>, yStart: CGFloat?, yEnd: CGFloat?) where X : Plottable {
        self.init(
            x: x,
            yStart: yStart,
            yEnd: yEnd,
            width: (try? element.attributeValue(MarkDimension.self, for: "width")) ?? .automatic,
            stacking: (try? element.attributeValue(MarkStackingMethod.self, for: "stacking")) ?? .standard
        )
    }
    
    init<Y>(element: ElementNode, xStart: CGFloat?, xEnd: CGFloat?, y: PlottableValue<Y>) where Y : Plottable {
        self.init(
            xStart: xStart,
            xEnd: xEnd,
            y: y,
            height: (try? element.attributeValue(MarkDimension.self, for: "height")) ?? .automatic,
            stacking: (try? element.attributeValue(MarkStackingMethod.self, for: "stacking")) ?? .standard
        )
    }
}

extension BarMark: FixedBidirectionalRangeMark {
    init<X>(element: ElementNode, xStart: PlottableValue<X>, xEnd: PlottableValue<X>, yStart: CGFloat?, yEnd: CGFloat?) where X : Plottable {
        self.init(
            xStart: xStart,
            xEnd: xEnd,
            yStart: yStart,
            yEnd: yEnd
        )
    }
    
    init<Y>(element: ElementNode, xStart: CGFloat?, xEnd: CGFloat?, yStart: PlottableValue<Y>, yEnd: PlottableValue<Y>) where Y : Plottable {
        self.init(
            xStart: xStart,
            xEnd: xEnd,
            yStart: yStart,
            yEnd: yEnd
        )
    }
}
