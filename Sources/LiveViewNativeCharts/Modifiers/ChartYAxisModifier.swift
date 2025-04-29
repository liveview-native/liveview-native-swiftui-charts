//
//  ChartYAxisModifier.swift
//
//
//  Created by Carson Katri on 6/14/23.
//

import Charts
import SwiftUI
import LiveViewNative
import LiveViewNativeStylesheet

@ASTDecodable("chartYAxis")
struct ChartYAxisModifier<R: RootRegistry>: ViewModifier, @preconcurrency Decodable {
    enum Storage {
        case visibility(Visibility.Resolvable)
        case content(ViewReference)
    }
    let storage: Storage
    
    @ObservedElement(observeChildren: true) private var element
    @ContentBuilderContext<R, AxisContentBuilder> private var context
    
    init(_ visibility: Visibility.Resolvable) {
        self.storage = .visibility(visibility)
    }
    
    init(content: ViewReference) {
        self.storage = .content(content)
    }
    
    func body(content: Content) -> some View {
        switch self.storage {
        case let .visibility(visibility):
            content.chartYAxis(visibility.resolve(on: element, in: context))
        case let .content(reference):
            content.chartYAxis {
                AnyAxisContent(
                    try! AxisContentBuilder.buildChildren(
                        of: element,
                        forTemplate: reference,
                        in: context
                    )
                )
            }
        }
    }
}
