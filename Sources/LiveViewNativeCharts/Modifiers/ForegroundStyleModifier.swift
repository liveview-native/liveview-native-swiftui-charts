//
//  ForegroundStyleModifier.swift
//
//
//  Created by Carson Katri on 6/8/23.
//

import Charts
import LiveViewNative

struct ForegroundStyleModifier: ContentModifier {
    typealias Builder = ChartContentBuilder
    
    let value: AnyPlottableValue
    
    func apply<R: RootRegistry>(
        to content: Builder.Content,
        on element: ElementNode,
        in context: Builder.Context<R>
    ) -> Builder.Content {
        func unbox(_ v: some Plottable) -> AnyChartContent {
            AnyChartContent(content.foregroundStyle(by: .value(value.label, v)))
        }
        return unbox(value.value)
    }
}
