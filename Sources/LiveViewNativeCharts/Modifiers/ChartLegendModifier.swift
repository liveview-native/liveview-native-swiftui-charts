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

@ASTDecodable("chartLegend")
@MainActor
struct ChartLegendModifier<R: RootRegistry>: ViewModifier, @preconcurrency Decodable {
    enum Storage {
        case visibility(Visibility.Resolvable)
        case content(
            position: AttributeReference<AnnotationPosition.Resolvable>,
            alignment: Alignment.Resolvable?,
            spacing: CGFloat.Resolvable?,
            content: ViewReference
        )
        case position(
            position: AttributeReference<AnnotationPosition.Resolvable>,
            alignment: Alignment.Resolvable?,
            spacing: CGFloat.Resolvable?
        )
    }
    let storage: Storage
    
    @ObservedElement private var element
    @LiveContext<R> private var context
    
    init(_ visibility: Visibility.Resolvable) {
        self.storage = .visibility(visibility)
    }
    
    @MainActor
    init(
        position: AttributeReference<AnnotationPosition.Resolvable> = .constant(.automatic),
        alignment: Alignment.Resolvable? = nil,
        spacing: CGFloat.Resolvable? = nil,
        content: ViewReference
    ) {
        self.storage = .content(
            position: position,
            alignment: alignment,
            spacing: spacing,
            content: content
        )
    }
    
    @MainActor
    init(
        position: AttributeReference<AnnotationPosition.Resolvable> = .constant(.automatic),
        alignment: Alignment.Resolvable? = nil,
        spacing: CGFloat.Resolvable? = nil
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
            content.chartLegend(visibility.resolve(on: element, in: context))
        case let .content(position, alignment, spacing, _content):
            content.chartLegend(position: position.resolve(on: element, in: context).resolve(on: element, in: context), alignment: alignment?.resolve(on: element, in: context), spacing: spacing?.resolve(on: element, in: context)) {
                _content.resolve(on: element, in: context)
            }
        case let .position(position, alignment, spacing):
            content.chartLegend(position: position.resolve(on: element, in: context).resolve(on: element, in: context), alignment: alignment?.resolve(on: element, in: context), spacing: spacing?.resolve(on: element, in: context))
        }
    }
}
