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
/// ## Arguments
/// * ``shape``
/// * ``style``
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
struct SymbolModifier: ContentModifier {
    typealias Builder = ChartContentBuilder
    
    ///
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    let shape: BasicChartSymbolShape?
    
    ///
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    let value: AnyPlottableValue?
    
    ///
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    let content: String?
    
    func apply<R: RootRegistry>(
        to content: Builder.Content,
        on element: ElementNode,
        in context: Builder.Context<R>
    ) -> Builder.Content {
        if let shape {
            return content.symbol(shape)
        } else if let value {
            return unbox(content: content, label: value.label, value.value)
        } else if let keyName = self.content {
            return content
                .symbol {
                    Builder.buildChildViews(
                        of: element,
                        forTemplate: keyName,
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
