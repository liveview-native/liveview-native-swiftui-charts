//
//  ChartXAxisModifier.swift
//
//
//  Created by Carson Katri on 6/14/23.
//

import Charts
import SwiftUI
import LiveViewNative
import LiveViewNativeStylesheet

@ParseableExpression
struct ChartXAxisModifier<R: RootRegistry>: ViewModifier {
    static var name: String { "chartXAxis" }
    
    enum Storage {
        case visibility(Visibility)
        case content(ViewReference)
    }
    let storage: Storage
    
    @ObservedElement(observeChildren: true) private var element
    @ContentBuilderContext<R, AxisContentBuilder> private var context
    
    init(_ visibility: Visibility) {
        self.storage = .visibility(visibility)
    }
    
    init(content: ViewReference) {
        self.storage = .content(content)
    }
    
    func body(content: Content) -> some View {
        switch self.storage {
        case let .visibility(visibility):
            content.chartXAxis(visibility)
        case let .content(reference):
            content.chartXAxis {
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
