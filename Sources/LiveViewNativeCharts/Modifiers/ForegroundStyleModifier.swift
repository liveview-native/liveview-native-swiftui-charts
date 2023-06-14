//
//  ForegroundStyleModifier.swift
//
//
//  Created by Carson Katri on 6/8/23.
//

import Charts
import SwiftUI
import LiveViewNative

/// Displays data with foreground colors.
///
/// Use this modifier to use a unique color for different categories on the same mark.
///
/// ```html
/// <BarMark
///   x={item.profit}
///   x:label="Profit"
///
///   modifiers={@native |> foreground_style(value: {"Product", item.product})}
/// />
/// ```
///
/// Alternatively, provide a `ShapeStyle` to set the color of a mark directly.
///
/// ```html
/// <RuleMark
///   y={item.min_height}
///   y:label="Minimum Height"
///
///   modifiers={@native |> foreground_style(primary: {:color, :red})}
/// />
/// ```
///
/// This modifier can also be applied to axis marks.
///
/// ```html
/// <AxisGridLine modifiers={@native |> foreground_style(primary: {:color, :red})} />
/// ```
///
/// ## Arguments
/// * ``value``
/// * ``primary``
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
struct ForegroundStyleModifier: ContentModifier {
    typealias Builder = ChartContentBuilder
    
    /// A plottable value used to differentiate elements of the graph.
    ///
    /// See ``AnyPlottableValue`` for more details.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    let value: AnyPlottableValue?
    
    /// The ``LiveViewNativeCharts/LiveViewNative/SwiftUI/AnyShapeStyle`` to apply.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    let primary: AnyShapeStyle?
    
    func apply<R: RootRegistry>(
        to content: Builder.Content,
        on element: ElementNode,
        in context: Builder.Context<R>
    ) -> Builder.Content {
        if let primary {
            return content.foregroundStyle(primary)
        } else if let value {
            return unbox(content: content, label: value.label, value.value)
        } else {
            return content
        }
    }
    
    func unbox(content: Builder.Content, label: String, _ v: some Plottable) -> AnyChartContent {
        AnyChartContent(content.foregroundStyle(by: .value(label, v)))
    }
}

extension ForegroundStyleModifier: AxisMarkModifier {
    func body(content: AnyAxisMark) -> some AxisMark {
        if let primary {
            content.foregroundStyle(primary)
        } else {
            content
        }
    }
}
