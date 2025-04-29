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

@ASTDecodable("chartBackground")
struct ChartBackgroundModifier<R: RootRegistry>: ViewModifier, @preconcurrency Decodable {
    let alignment: Alignment.Resolvable
    let content: ViewReference
    
    @ObservedElement private var element
    @LiveContext<R> private var context
    
    init(alignment: Alignment.Resolvable, content: ViewReference) {
        self.alignment = alignment
        self.content = content
    }

    func body(content: Content) -> some View {
        content.chartBackground(alignment: self.alignment.resolve(on: element, in: context)) { _ in
            self.content.resolve(on: element, in: context)
        }
    }
}
