//
//  ZIndexModifier.swift
//
//
//  Created by Carson Katri on 7/5/23.
//

import Charts
import LiveViewNative
import LiveViewNativeStylesheet

@ASTDecodable("zIndex")
struct ZIndexModifier: ContentModifier, @preconcurrency Decodable {
    typealias Builder = ChartContentBuilder
    
    let value: Double.Resolvable
    
    @available(iOS 17, macOS 14, tvOS 17, watchOS 10, *)
    init(_ value: Double.Resolvable) {
        self.value = value
    }
    
    func apply<R: RootRegistry>(
        to content: Builder.Content,
        on element: ElementNode,
        in context: Builder.Context<R>
    ) -> Builder.Content {
        if #available(iOS 17, macOS 14, tvOS 17, watchOS 10, *) {
            return content.zIndex(value.resolve(on: element, in: context))
        } else {
            return content
        }
    }
}
