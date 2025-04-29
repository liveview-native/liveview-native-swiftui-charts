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

@ASTDecodable("font")
@MainActor
struct FontModifier: ContentModifier, @preconcurrency Decodable {
    typealias Builder = AxisMarkBuilder
    
    private let font: Font.Resolvable
    
    init(_ font: Font.Resolvable) {
        self.font = font
    }
    
    func apply<R: RootRegistry>(
        to content: Builder.Content,
        on element: ElementNode,
        in context: Builder.Context<R>
    ) -> Builder.Content {
        content.font(font.resolve(on: element, in: context))
    }
}
