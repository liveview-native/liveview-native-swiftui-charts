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

@ParseableExpression
struct ChartOverlayModifier<R: RootRegistry>: ViewModifier {
    static var name: String { "chartOverlay" }
    
    private let alignment: Alignment
    private let content: ViewReference
    
    @ObservedElement private var element
    @LiveContext<R> private var context
    
    init(alignment: Alignment, content: ViewReference) {
        self.alignment = alignment
        self.content = content
    }
    
    func body(content: Content) -> some View {
        content.chartOverlay(alignment: alignment) { _ in
            self.content.resolve(on: element, in: context)
        }
    }
}
