//
//  AlignsMarkStylesWithPlotAreaModifier.swift
//
//
//  Created by Carson Katri on 7/5/23.
//

import Charts
import LiveViewNative
import LiveViewNativeStylesheet

@ParseableExpression
struct AlignsMarkStylesWithPlotAreaModifier: ContentModifier {
    typealias Builder = ChartContentBuilder
    
    static let name = "alignsMarkStylesWithPlotArea"
    
    let aligns: Bool
    
    init(aligns: Bool) {
        self.aligns = aligns
    }
    
    func apply<R: RootRegistry>(
        to content: Builder.Content,
        on element: ElementNode,
        in context: Builder.Context<R>
    ) -> Builder.Content {
        content.alignsMarkStylesWithPlotArea(aligns)
    }
}
