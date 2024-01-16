//
//  File.swift
//  
//
//  Created by Carson.Katri on 6/14/23.
//

import Charts
import SwiftUI
import LiveViewNative
import LiveViewNativeStylesheet

@ParseableExpression
struct FontModifier: ContentModifier {
    typealias Builder = AxisMarkBuilder
    
    static let name = "font"
    
    private let font: Font
    
    init(_ font: Font) {
        self.font = font
    }
    
    func apply<R: RootRegistry>(
        to content: Builder.Content,
        on element: ElementNode,
        in context: Builder.Context<R>
    ) -> Builder.Content {
        content.font(font)
    }
}
