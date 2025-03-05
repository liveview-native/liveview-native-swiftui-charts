//
//  OffsetModifier.swift
//
//
//  Created by Carson Katri on 6/8/23.
//

import Charts
import LiveViewNative
import LiveViewNativeStylesheet

@ASTDecodable("offset")
@MainActor
struct OffsetModifier: ContentModifier, @preconcurrency Decodable {
    typealias Builder = ChartContentBuilder
    
    let x: Double.Resolvable
    let y: Double.Resolvable
    
    init(x: Double.Resolvable, y: Double.Resolvable) {
        self.x = x
        self.y = y
    }
    
    func apply<R: RootRegistry>(
        to content: Builder.Content,
        on element: ElementNode,
        in context: Builder.Context<R>
    ) -> Builder.Content {
        content.offset(x: x.resolve(on: element, in: context), y: y.resolve(on: element, in: context))
    }
}

@ASTDecodable("offset")
@MainActor
struct AxisMarkOffsetModifier: ContentModifier, @preconcurrency Decodable {
    typealias Builder = AxisMarkBuilder
    
    static let name = "offset"
    
    let x: Double.Resolvable
    let y: Double.Resolvable
    
    init(x: Double.Resolvable = .__constant(0), y: Double.Resolvable = .__constant(0)) {
        self.x = x
        self.y = y
    }
    
    func apply<R: RootRegistry>(
        to content: Builder.Content,
        on element: ElementNode,
        in context: Builder.Context<R>
    ) -> Builder.Content {
        content.offset(x: x.resolve(on: element, in: context), y: y.resolve(on: element, in: context))
    }
}
