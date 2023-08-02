//
//  SymbolSizeModifier.swift
//
//
//  Created by Carson Katri on 7/5/23.
//

import Charts
import SwiftUI
import LiveViewNative

/// Displays data with symbol sizes.
///
/// Use this modifier to use a unique size for different categories on the same mark.
///
/// ```html
/// <LineMark
///   x={item.date}
///   x:label="Date"
///
///   y={item.profit}
///   y:label="Profit"
///
///   modifiers={symbol(shape: :triangle) |> symbol_size(by: {"Product", item.product})}
/// />
/// ```
///
/// Alternatively, set a manual ``size`` or ``area`` for the symbol.
///
/// ```html
/// <LineMark
///   ...
///   modifiers={symbol(shape: :square) |> symbol_size([20, 20])}
/// />
/// ```
///
/// ## Arguments
/// * ``value``
/// * ``area``
/// * ``size``
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
struct SymbolSizeModifier: ContentModifier {
    typealias Builder = ChartContentBuilder
    
    /// A plottable value used to differentiate elements of the chart.
    ///
    /// See ``AnyPlottableValue`` for more details.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    let value: AnyPlottableValue?
    
    /// A manual size for the symbol.
    ///
    /// The value represents a visual area the symbol should take up.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    let area: CGFloat?
    
    /// A manual size for the symbol.
    ///
    /// Use an array to represent the size: `[x, y]`.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    let size: CGSize?
    
    func apply<R: RootRegistry>(
        to content: Builder.Content,
        on element: ElementNode,
        in context: Builder.Context<R>
    ) -> Builder.Content {
        if let value {
            return unbox(content: content, label: value.label, value.value)
        } else if let area {
            return content.symbolSize(area)
        } else if let size {
            return content.symbolSize(size)
        } else {
            return content
        }
    }
    
    func unbox(content: Builder.Content, label: String, _ v: some Plottable) -> Builder.Content {
        content.symbolSize(by: .value(label, v))
    }
}
