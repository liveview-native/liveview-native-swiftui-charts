//
//  LineMark.swift
//
//
//  Created by Carson Katri on 6/13/23.
//

import Charts
import LiveViewNative

/// A mark that displays a line.
///
/// ```html
/// <LineMark
///   x:label="Date"
///   x:value={item.date}
///
///   y:label="Profit"
///   y:value={item.profit}
/// />
/// ```
///
/// To plot multiple lines by category, use the `series` attribute.
///
/// ```html
/// <LineMark
///   x:label="Date"
///   x:value={item.date}
///
///   y:label="Profit"
///   y:value={item.profit}
///
///   series:label="Product"
///   series:value={item.product}
/// />
/// ```
///
/// Alternatively, the ``ForegroundStyleModifier`` modifier can be used to plot each line in a separate color.
///
/// ## Attributes
/// * `x`
/// * `y`
/// * `series`
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
extension LineMark: SimpleMark {
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    init<X, Y>(element: ElementNode, x: PlottableValue<X>, y: PlottableValue<Y>) where X : Plottable, Y : Plottable {
        self.init(x: x, y: y)
    }
}

extension LineMark: SeriesMark {
    init<X, Y, S>(element: ElementNode, x: PlottableValue<X>, y: PlottableValue<Y>, series: PlottableValue<S>) where X : Plottable, Y : Plottable, S : Plottable {
        self.init(x: x, y: y, series: series)
    }
}
