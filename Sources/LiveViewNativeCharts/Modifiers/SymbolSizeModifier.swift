//
//  SymbolSizeModifier.swift
//
//
//  Created by Carson Katri on 7/5/23.
//

import Charts
import SwiftUI
import LiveViewNative
import LiveViewNativeStylesheet

@ParseableExpression
struct SymbolSizeModifier: ContentModifier {
    typealias Builder = ChartContentBuilder
    
    static let name = "symbolSize"
    
    enum Storage {
        case value(AnyPlottableValue)
        case area(CGFloat)
        case size(CGSize)
    }
    
    let storage: Storage
    
    init(by value: AnyPlottableValue) {
        self.storage = .value(value)
    }
    
    init(_ area: CGFloat) {
        self.storage = .area(area)
    }
    
    init(_ size: CGSize) {
        self.storage = .size(size)
    }
    
    func apply<R: RootRegistry>(
        to content: Builder.Content,
        on element: ElementNode,
        in context: Builder.Context<R>
    ) -> Builder.Content {
        switch storage {
        case let .value(value):
            return unbox(content: content, label: value.label, value.value.resolve(on: element), on: element, in: context)
        case let .area(area):
            return content.symbolSize(area)
        case let .size(size):
            return content.symbolSize(size)
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
            content.symbolSize(by: .value(label, v))
        case .text(let label):
            content.symbolSize(by: .value(Builder.buildChildText(of: element, forTemplate: label, in: context), v))
        }
    }
}
