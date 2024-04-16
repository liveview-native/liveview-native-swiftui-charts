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

@ParseableExpression
struct ForegroundStyleModifier: ContentModifier {
    typealias Builder = ChartContentBuilder
    
    static let name = "foregroundStyle"
    
    enum Storage {
        case primary(AnyShapeStyle)
        case value(AnyPlottableValue)
    }
    
    let storage: Storage
    
    init(_ primary: AnyShapeStyle) {
        self.storage = .primary(primary)
    }
    
    init(by value: AnyPlottableValue) {
        self.storage = .value(value)
    }
    
    func apply<R: RootRegistry>(
        to content: Builder.Content,
        on element: ElementNode,
        in context: Builder.Context<R>
    ) -> Builder.Content {
        switch storage {
        case let .primary(primary):
            return content.foregroundStyle(primary)
        case let .value(value):
            return unbox(
                content: content,
                label: value.label,
                value.value.resolve(on: element).value,
                on: element,
                in: context
            )
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
            content.foregroundStyle(by: .value(label, v))
        case .text(let label):
            content.foregroundStyle(by: .value(Builder.buildChildText(of: element, forTemplate: label, in: context), v))
        }
    }
}

@ParseableExpression
struct AxisMarkForegroundStyleModifier: ContentModifier {
    typealias Builder = AxisMarkBuilder
    
    static let name = "foregroundStyle"
    
    let primary: AnyShapeStyle
    
    init(_ primary: AnyShapeStyle) {
        self.primary = primary
    }
    
    func apply<R: RootRegistry>(
        to content: Builder.Content,
        on element: ElementNode,
        in context: Builder.Context<R>
    ) -> Builder.Content {
        return content.foregroundStyle(primary)
    }
}
