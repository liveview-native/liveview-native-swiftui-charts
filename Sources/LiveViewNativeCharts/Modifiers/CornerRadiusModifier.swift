//
//  CornerRadiusModifier.swift
//
//
//  Created by Carson Katri on 7/4/23.
//

import Charts
import SwiftUI
import LiveViewNative
import LiveViewNativeStylesheet

@ASTDecodable("cornerRadius")
struct CornerRadiusModifier: ContentModifier, @preconcurrency Decodable {
    typealias Builder = ChartContentBuilder
    
    private let radius: CGFloat
    private let style: RoundedCornerStyle
    
    init(_ radius: CGFloat, style: RoundedCornerStyle = .continuous) {
        self.radius = radius
        self.style = style
    }
    
    func apply<R: RootRegistry>(
        to content: Builder.Content,
        on element: ElementNode,
        in context: Builder.Context<R>
    ) -> Builder.Content {
        content.cornerRadius(radius, style: style)
    }
}
