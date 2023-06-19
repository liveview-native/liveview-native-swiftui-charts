//
//  SymbolModifier.swift
//
//
//  Created by Carson Katri on 6/19/23.
//

import Charts
import SwiftUI
import LiveViewNative

/// Sets the shape or elements to display as the symbols on a mark.
///
/// Use this with ``LiveViewNativeCharts/Charts/LineMark`` to customize the symbol.
///
/// A predefined symbol shape is the easiest way to customize the symbol for all marks.
/// See ``LiveViewNativeCharts/Charts/BasicChartSymbolShape`` for a list of possible values.
///
/// ```html
/// <LineMark
///   ...
///   modifiers={@native |> symbol(shape: :diamond)}
/// />
/// ```
///
/// Use the ``value`` argument to customize the symbol based on some plottable value, for example a product category.
///
/// ```html
/// <LineMark
///   ...
///   modifiers={@native |> symbol(value: {"Category", item.category})}
/// />
/// ```
///
/// The ``symbol`` argument allows a template element to be used as the symbol.
///
/// ```html
/// <LineMark
///   ...
///   modifiers={@native |> symbol(symbol: :my_symbol)}
/// >
///   <Text template={:my_symbol}>
///     Hello, world!
///   </Text>
/// </LineMark>
/// ```
///
/// ## Arguments
/// * ``shape``
/// * ``value``
/// * ``symbol``
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
struct SymbolModifier: ContentModifier {
    typealias Builder = ChartContentBuilder
    
    /// A predefined shape to use as the symbol.
    ///
    /// See ``LiveViewNativeCharts/Charts/BasicChartSymbolShape`` for a list of possible values.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    let shape: BasicChartSymbolShape?
    
    /// Choose a symbol based on a plottable value.
    ///
    /// See ``AnyPlottableValue`` for more details.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    let value: AnyPlottableValue?
    
    /// The key name for a template element to use as the symbol.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    let symbol: String?
    
    func apply<R: RootRegistry>(
        to content: Builder.Content,
        on element: ElementNode,
        in context: Builder.Context<R>
    ) -> Builder.Content {
        if let shape {
            return content.symbol(shape)
        } else if let value {
            return unbox(content: content, label: value.label, value.value)
        } else if let symbol = self.symbol {
            return content
                .symbol {
                    Builder.buildChildViews(
                        of: element,
                        forTemplate: symbol,
                        in: context
                    )
                }
        } else {
            return content
        }
    }
    
    func unbox(content: Builder.Content, label: String, _ v: some Plottable) -> Builder.Content {
        content.symbol(by: .value(label, v))
    }
}
