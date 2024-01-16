//
//  ChartBackgroundModifier.swift
//
//
//  Created by murtza on 22/06/2023.
//

import Charts
import SwiftUI
import LiveViewNative
import LiveViewNativeStylesheet

@ParseableExpression
struct ChartBackgroundModifier<R: RootRegistry>: ViewModifier {
    static var name: String { "chartBackground" }
    
    let alignment: Alignment
    let content: ViewReference
    
    @ObservedElement private var element
    @LiveContext<R> private var context
    
    init(alignment: Alignment, content: ViewReference) {
        self.alignment = alignment
        self.content = content
    }

    func body(content: Content) -> some View {
        content.chartBackground(alignment: self.alignment) { _ in
            self.content.resolve(on: element, in: context)
        }
    }
}
