//
//  SymbolModifier.swift
//
//
//  Created by Carson Katri on 6/19/23.
//

import Charts
import SwiftUI
import LiveViewNative
import LiveViewNativeStylesheet

@ParseableExpression
enum SymbolModifier: ContentModifier {
    typealias Builder = ChartContentBuilder
    
    static let name = "symbol"
    
    case shape(BasicChartSymbolShape)
    case value(AnyPlottableValue)
    case view(ViewReference)
    
    init(_ symbol: BasicChartSymbolShape) {
        self = .shape(symbol)
    }
    
    init(by value: AnyPlottableValue) {
        self = .value(value)
    }

    init(symbol: ViewReference) {
        self = .view(symbol)
    }
    
    func apply<R: RootRegistry>(
        to content: Builder.Content,
        on element: ElementNode,
        in context: Builder.Context<R>
    ) -> Builder.Content {
        switch self {
        case .shape(let shape):
            return content.symbol(shape)
        case .value(let value):
            return unbox(content: content, label: value.label, value.value.resolve(on: element, in: LiveContext<R>()).value, on: element, in: context)
        case .view(let view):
            return content
                .symbol {
                    Builder.buildChildViews(
                        of: element,
                        forTemplate: view,
                        in: context
                    )
                }
        }
    }
    
    func unbox<R: RootRegistry>(
        content: Builder.Content,
        label: AnyPlottableValue.Label,
        _ v: some Plottable,
        on element: ElementNode,
        in context: Builder.Context<R>
    ) -> Builder.Content {
        switch label {
        case .constant(let label):
            content.symbol(by: .value(label, v))
        case .text(let label):
            content.symbol(by: .value(Builder.buildChildText(of: element, forTemplate: label, in: context), v))
        }
    }
}
