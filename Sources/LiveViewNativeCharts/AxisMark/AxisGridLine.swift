//
//  AxisGridLine.swift
//
//
//  Created by Carson Katri on 6/14/23.
//

import Charts
import SwiftUI
import LiveViewNative

/// An axis mark that adds grid lines.
///
/// Use this element in the content of an ``AxisMarks`` element to display grid lines in your chart.
///
/// ```html
/// <AxisMarks>
///   <AxisGridLine
///     centered
///     modifiers={foreground_style(@native, primary: {:color, :red})}
///   />
/// </AxisMarks>
/// ```
///
/// ## Attributes
/// * `centered` - Centers the grid lines between two axes.
/// * `stroke` - The ``LiveViewNativeCharts/SwiftUI/StrokeStyle`` to use.
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
struct AxisGridLine: ComposedAxisMark {
    let element: ElementNode
    
    var body: some AxisMark {
        Charts.AxisGridLine(
            centered: element.attributeBoolean(for: "centered"),
            stroke: try? element.attributeValue(StrokeStyle.self, for: "stroke")
        )
    }
}
