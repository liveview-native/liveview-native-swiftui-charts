//
//  OffsetModifier.swift
//
//
//  Created by Carson Katri on 6/28/23.
//

import Charts
import LiveViewNative
import LiveViewNativeStylesheet

@ASTDecodable("interpolationMethod")
@MainActor
struct InterpolationMethodModifier: ContentModifier, @preconcurrency Decodable {
    typealias Builder = ChartContentBuilder
    
    let method: InterpolationMethod.Resolvable
    
    init(_ method: InterpolationMethod.Resolvable) {
        self.method = method
    }
    
    func apply<R: RootRegistry>(
        to content: Builder.Content,
        on element: ElementNode,
        in context: Builder.Context<R>
    ) -> Builder.Content {
        content.interpolationMethod(method.resolve(on: element, in: context))
    }
}
