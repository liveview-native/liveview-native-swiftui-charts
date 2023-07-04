//
//  LineStyleModifier.swift
//
//
//  Created by Carson Katri on 7/4/23.
//

import Charts
import SwiftUI
import LiveViewNative

/// Displays data with line styles.
///
/// Use this modifier to use a unique line style for different categories on the same mark.
///
/// ```html
/// <LineMark
///   x={item.date}
///   x:label="Date"
///
///   y={item.profit}
///   y:label="Profit"
///
///   modifiers={line_style(by: {"Product", item.product})}
/// />
/// ```
///
/// Alternatively, provide a `StrokeStyle` to set the style of a mark directly.
///
/// ```html
/// <RuleMark
///   y={@min_height}
///   y:label="Minimum Height"
///
///   modifiers={line_style([line_width: 10, dash: [10, 5]])}
/// />
/// ```
///
/// ## Arguments
/// * ``value``
/// * ``style``
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
struct LineStyleModifier: ContentModifier {
    typealias Builder = ChartContentBuilder
    
    /// A plottable value used to differentiate elements of the graph.
    ///
    /// See ``AnyPlottableValue`` for more details.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    let value: AnyPlottableValue?
    
    /// The ``LiveViewNativeCharts/LiveViewNative/SwiftUI/StrokeStyle`` to apply.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    let style: StrokeStyle?
    
    func apply<R: RootRegistry>(
        to content: Builder.Content,
        on element: ElementNode,
        in context: Builder.Context<R>
    ) -> Builder.Content {
        if let style {
            return content.lineStyle(style)
        } else if let value {
            return unbox(content: content, label: value.label, value.value)
        } else {
            return content
        }
    }
    
    func unbox(content: Builder.Content, label: String, _ v: some Plottable) -> Builder.Content {
        content.lineStyle(by: .value(label, v))
    }
}
