//
//  ChartLegendModifier.swift
//
//
//  Created by Carson Katri on 5/16/24.
//

import Charts
import SwiftUI
import LiveViewNative
import LiveViewNativeStylesheet

@ParseableExpression
struct ChartLegendModifier<R: RootRegistry>: ViewModifier {
    static var name: String { "chartLegend" }
    
    enum Storage {
        case visibility(Visibility)
        case content(
            position: AnnotationPosition,
            alignment: Alignment?,
            spacing: CGFloat?,
            content: ViewReference
        )
        case position(
            position: AnnotationPosition,
            alignment: Alignment?,
            spacing: CGFloat?
        )
    }
    let storage: Storage
    
    @ObservedElement private var element
    @LiveContext<R> private var context
    
    init(_ visibility: Visibility) {
        self.storage = .visibility(visibility)
    }
    
    init(
        position: AnnotationPosition = .automatic,
        alignment: Alignment? = nil,
        spacing: CGFloat? = nil,
        content: ViewReference
    ) {
        self.storage = .content(
            position: position,
            alignment: alignment,
            spacing: spacing,
            content: content
        )
    }
    
    init(
        position: AnnotationPosition = .automatic,
        alignment: Alignment? = nil,
        spacing: CGFloat? = nil
    ) {
        self.storage = .position(
            position: position,
            alignment: alignment,
            spacing: spacing
        )
    }
    
    func body(content: Content) -> some View {
        switch self.storage {
        case let .visibility(visibility):
            content.chartLegend(visibility)
        case let .content(position, alignment, spacing, _content):
            content.chartLegend(position: position, alignment: alignment, spacing: spacing) {
                _content.resolve(on: element, in: context)
            }
        case let .position(position, alignment, spacing):
            content.chartLegend(position: position, alignment: alignment, spacing: spacing)
        }
    }
}
