//
//  ClipShapeModifier.swift
//  
//
//  Created by Carson Katri on 6/27/23.
//

import Charts
import SwiftUI
import LiveViewNative

// this modifier is created by `liveview-client-swiftui`, and an implementation for Charts is provided here.
/// Masks an element with a given shape.
///
/// Provide a ``LiveViewNativeCharts/LiveViewNative/ShapeReference`` to clip the element with.
///
/// ```html
/// <BarMark modifiers={clip_shape(shape: :capsule)} ... />
/// ```
///
/// If the shape is not predefined, provide a ``LiveViewNativeCharts/LiveViewNative/Shape`` element with a `template` attribute.
/// This lets you apply modifiers to the clip shape.
///
/// ```html
/// <BarMark modifiers={clip_shape(shape: :my_shape)} ...>
///     <Rectangle template={:my_shape} modifiers={rotation(angle: {:degrees, 45})} />
/// </BarMark>
/// ```
///
/// ## Arguments
/// * ``shape``
/// * ``style``
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
struct ClipShapeModifier: ContentModifier {
    typealias Builder = ChartContentBuilder
    
    /// The shape to use as a mask.
    ///
    /// See ``ShapeReference`` for more details on creating shape arguments.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private let shape: ShapeReference

    /// The style to use when filling the ``shape`` for the mask.
    ///
    /// See ``LiveViewNative/SwiftUI/FillStyle`` for more details.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private let style: FillStyle

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.shape = try container.decode(ShapeReference.self, forKey: .shape)
        self.style = try container.decodeIfPresent(FillStyle.self, forKey: .style) ?? .init()
    }

    func apply<R>(
        to content: Builder.Content,
        on element: ElementNode,
        in context: Builder.Context<R>
    ) -> Builder.Content where R : RootRegistry {
        content.clipShape(
            shape.resolve(on: element),
            style: style
        )
    }

    enum CodingKeys: String, CodingKey {
        case shape
        case style
    }
}
