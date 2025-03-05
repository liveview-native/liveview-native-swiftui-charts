//
//  ChartOverlayModifier.swift
//
//
//  Created by Carson Katri on 7/5/23.
//

import Charts
import SwiftUI
import LiveViewNative
import LiveViewNativeStylesheet

@ASTDecodable("chartOverlay")
struct ChartOverlayModifier<R: RootRegistry>: ViewModifier, @preconcurrency Decodable {
    private let alignment: Alignment.Resolvable
    private let content: ViewReference
    
    @ObservedElement private var element
    @LiveContext<R> private var context
    
    init(alignment: Alignment.Resolvable, content: ViewReference) {
        self.alignment = alignment
        self.content = content
    }
    
    func body(content: Content) -> some View {
        content.chartOverlay(alignment: alignment.resolve(on: element, in: context)) { _ in
            self.content.resolve(on: element, in: context)
        }
    }
}
