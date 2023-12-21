//
//  OffsetModifier.swift
//
//
//  Created by Carson Katri on 6/28/23.
//

import Charts
import LiveViewNative
import LiveViewNativeStylesheet

@ParseableExpression
struct InterpolationMethodModifier: ContentModifier {
    typealias Builder = ChartContentBuilder
    
    static let name = "interpolationMethod"
    
    let method: InterpolationMethod
    
    init(_ method: InterpolationMethod) {
        self.method = method
    }
    
    func apply<R: RootRegistry>(
        to content: Builder.Content,
        on element: ElementNode,
        in context: Builder.Context<R>
    ) -> Builder.Content {
        content.interpolationMethod(method)
    }
}
