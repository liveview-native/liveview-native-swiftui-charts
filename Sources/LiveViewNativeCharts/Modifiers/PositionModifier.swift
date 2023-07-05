//
//  PositionModifier.swift
//
//
//  Created by Carson Katri on 7/5/23.
//

import Charts
import SwiftUI
import LiveViewNative

// this modifier is created by `liveview-client-swiftui`, and an implementation for Charts is provided here.
/// Position marks with a plottable value.
///
/// Use this modifier on a mark to set its position based on a plottable value.
/// Optionally provide an ``axis`` and ``span`` to customize the positioning.
///
/// ```html
/// <BarMark modifiers={position(by: {"Type", item.type}, axis: :horizontal)} />
/// ```
///
/// ## Arguments
/// * ``value``
/// * ``axis``
/// * ``span``
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
struct PositionModifier: ContentModifier {
    typealias Builder = ChartContentBuilder
    
    /// The plottable value used for positioning marks.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    let value: AnyPlottableValue
    
    /// The axis marks are positioned along.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    let axis: Axis?
    
    /// The total space available for marks.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    let span: MarkDimension?
    
    func apply<R: RootRegistry>(
        to content: Builder.Content,
        on element: ElementNode,
        in context: Builder.Context<R>
    ) -> Builder.Content {
        unbox(content: content, label: value.label, value.value)
    }
    
    func unbox(content: Builder.Content, label: String, _ v: some Plottable) -> Builder.Content {
        content.position(by: .value(label, v), axis: axis, span: span ?? .automatic)
    }
}
