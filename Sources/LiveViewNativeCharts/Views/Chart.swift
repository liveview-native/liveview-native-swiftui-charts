//
//  Chart.swift
//
//
//  Created by Carson Katri on 6/8/23.
//

import SwiftUI
import LiveViewNative
import Charts

/// An element that displays a chart.
///
/// Use this element to create a chart.
/// In the chart's contents, use <doc:Marks> to display data.
///
/// ```html
/// <Chart>
///   <%= for item <- @data do %>
///     <BarMark
///       x={item.department}
///       x:label="Department"
///
///       y={item.profit}
///       y:label="Profit"
///
///       modifiers={@native |> foreground_style(value: {"Product Category", item.product_category})}
///     />
///   <% end %>
/// </Chart>
/// ```
///
/// - Note: Only some elements, such as marks, can be used in the content of a chart. Other types of elements are not supported.
///
/// Use modifiers to customize the chart's style, axes, etc.
public struct Chart<R: RootRegistry>: View {
    @ObservedElement(observeChildren: true) private var element
    @ContentBuilderContext<R, ChartContentBuilder> private var context
    
    public var body: some View {
        Charts.Chart {
            AnyChartContent(try! ChartContentBuilder.buildChildren(of: element, in: context))
        }
    }
}
