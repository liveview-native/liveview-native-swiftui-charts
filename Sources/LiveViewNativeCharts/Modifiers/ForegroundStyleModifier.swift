//
//  ForegroundStyleModifier.swift
//
//
//  Created by Carson Katri on 6/8/23.
//

import Charts
import SwiftUI
import LiveViewNative

struct ForegroundStyleModifier: ContentModifier {
    typealias Builder = ChartContentBuilder
    
    let value: AnyPlottableValue?
    let primary: AnyShapeStyle?
    
    func apply<R: RootRegistry>(
        to content: Builder.Content,
        on element: ElementNode,
        in context: Builder.Context<R>
    ) -> Builder.Content {
        if let primary {
            content.foregroundStyle(primary)
        } else if let value {
            unbox(content: content, label: value.label, value.value)
        } else {
            content
        }
    }
    
    func unbox(content: Builder.Content, label: String, _ v: some Plottable) -> AnyChartContent {
        AnyChartContent(content.foregroundStyle(by: .value(label, v)))
    }
}
