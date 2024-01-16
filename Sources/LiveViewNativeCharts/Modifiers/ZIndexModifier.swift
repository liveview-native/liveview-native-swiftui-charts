//
//  ZIndexModifier.swift
//
//
//  Created by Carson Katri on 7/5/23.
//

import Charts
import LiveViewNative
import LiveViewNativeStylesheet

@ParseableExpression
struct ZIndexModifier: ContentModifier {
    typealias Builder = ChartContentBuilder
    
    static let name = "zIndex"
    
    let value: Double
    
    @available(iOS 17, macOS 14, tvOS 17, watchOS 10, *)
    init(_ value: Double) {
        self.value = value
    }
    
    func apply<R: RootRegistry>(
        to content: Builder.Content,
        on element: ElementNode,
        in context: Builder.Context<R>
    ) -> Builder.Content {
        if #available(iOS 17, macOS 14, tvOS 17, watchOS 10, *) {
            return content.zIndex(value)
        } else {
            return content
        }
    }
}
