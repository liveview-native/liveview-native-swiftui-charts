//
//  File.swift
//  
//
//  Created by Carson.Katri on 6/27/23.
//

import Charts
import SwiftUI
import LiveViewNative

// this modifier is created by `liveview-client-swiftui`, and an implementation for Charts is provided here.
/// Adds a shadow behind the chart content.
///
/// Use this modifier to style a mark.
///
/// ```html
/// <BarMark modifiers={shadow(color: :black, radius: 10)} ... />
/// ```
///
/// ## Arguments
/// * ``color``
/// * ``radius``
/// * ``x``
/// * ``y``
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
@available(iOS 16.4, macOS 13.3, tvOS 16.4, watchOS 9.4, *)
struct ShadowModifier: ContentModifier {
    typealias Builder = ChartContentBuilder
    
    /// The shadow’s color.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private let color: SwiftUI.Color

    /// A measure of how much to blur the shadow. Larger values result in more blur.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private let radius: CGFloat

    /// An amount to offset the shadow horizontally from the view. Defaults to 0.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private let x: CGFloat

    /// An amount to offset the shadow vertically from the view. Defaults to 0.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private let y: CGFloat
    
    func apply<R: RootRegistry>(
        to content: Builder.Content,
        on element: ElementNode,
        in context: Builder.Context<R>
    ) -> Builder.Content {
        content.shadow(
            color: color,
            radius: radius,
            x: x,
            y: y
        )
    }
}
