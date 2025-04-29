//
//  ForegroundStyleModifier.swift
//
//
//  Created by Carson Katri on 6/8/23.
//

import Charts
import SwiftUI
import LiveViewNative
import LiveViewNativeStylesheet

@ASTDecodable("foregroundStyle")
@MainActor
struct ForegroundStyleModifier: ContentModifier, @preconcurrency Decodable {
    typealias Builder = ChartContentBuilder
    
    enum Storage {
        case primary(StylesheetResolvableShapeStyle)
        case value(AnyPlottableValue)
    }
    
    let storage: Storage
    
    init(_ primary: StylesheetResolvableShapeStyle) {
        self.storage = .primary(primary)
    }
    
    init(by value: AnyPlottableValue) {
        self.storage = .value(value)
    }
    
    @MainActor
    func apply<R: RootRegistry>(
        to content: Builder.Content,
        on element: ElementNode,
        in context: Builder.Context<R>
    ) -> Builder.Content {
        switch storage {
        case let .primary(primary):
            return content.foregroundStyle(primary.resolve(on: element, in: context))
        case let .value(value):
            let resolvedPlottable = value.value.resolve(on: element, in: context).value
            return unbox(
                content: content,
                label: value.label,
                resolvedPlottable,
                on: element,
                in: context
            )
        }
    }
    
    @MainActor
    func unbox<R: RootRegistry>(
        content: Builder.Content,
        label: AnyPlottableValue.Label,
        _ v: some Plottable,
        on element: ElementNode,
        in context: Builder.Context<R>
    ) -> Builder.Content {
        switch label {
        case .constant(let label):
            content.foregroundStyle(by: .value(label, v))
        case .text(let label):
            content.foregroundStyle(by: .value(Builder.buildChildText(of: element, forTemplate: label, in: context), v))
        }
    }
}

@ASTDecodable("foregroundStyle")
@MainActor
struct AxisMarkForegroundStyleModifier: ContentModifier, @preconcurrency Decodable {
    typealias Builder = AxisMarkBuilder
    
    let primary: StylesheetResolvableShapeStyle
    
    init(_ primary: StylesheetResolvableShapeStyle) {
        self.primary = primary
    }
    
    func apply<R: RootRegistry>(
        to content: Builder.Content,
        on element: ElementNode,
        in context: Builder.Context<R>
    ) -> Builder.Content {
        return content.foregroundStyle(primary.resolve(on: element, in: context))
    }
}
