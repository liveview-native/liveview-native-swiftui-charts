//
//  OffsetModifier.swift
//
//
//  Created by Carson Katri on 6/8/23.
//

import Charts
import LiveViewNative
import LiveViewNativeStylesheet

@ParseableExpression
struct OffsetModifier: ContentModifier {
    typealias Builder = ChartContentBuilder
    
    static let name = "offset"
    
    let x: Double
    let y: Double
    
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
    
    func apply<R: RootRegistry>(
        to content: Builder.Content,
        on element: ElementNode,
        in context: Builder.Context<R>
    ) -> Builder.Content {
        content.offset(x: x, y: y)
    }
}

@ParseableExpression
struct AxisMarkOffsetModifier: ContentModifier {
    typealias Builder = AxisMarkBuilder
    
    static let name = "offset"
    
    let x: Double
    let y: Double
    
    init(x: Double = 0, y: Double = 0) {
        self.x = x
        self.y = y
    }
    
    func apply<R: RootRegistry>(
        to content: Builder.Content,
        on element: ElementNode,
        in context: Builder.Context<R>
    ) -> Builder.Content {
        content.offset(x: x, y: y)
    }
}
