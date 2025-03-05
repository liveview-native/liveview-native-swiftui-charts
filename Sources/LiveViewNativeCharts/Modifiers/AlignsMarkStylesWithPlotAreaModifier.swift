//
//  AlignsMarkStylesWithPlotAreaModifier.swift
//
//
//  Created by Carson Katri on 7/5/23.
//

import Charts
import LiveViewNative
import LiveViewNativeStylesheet

@ASTDecodable("alignsMarkStylesWithPlotArea")
@MainActor
struct AlignsMarkStylesWithPlotAreaModifier: ContentModifier, @preconcurrency Decodable {
    typealias Builder = ChartContentBuilder
    
    let aligns: AttributeReference<Bool>
    
    init(aligns: AttributeReference<Bool>) {
        self.aligns = aligns
    }
    
    func apply<R: RootRegistry>(
        to content: Builder.Content,
        on element: ElementNode,
        in context: Builder.Context<R>
    ) -> Builder.Content {
        content.alignsMarkStylesWithPlotArea(aligns.resolve(on: element, in: context))
    }
}
