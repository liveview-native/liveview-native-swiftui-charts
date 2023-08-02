//
//  CornerRadiusModifier.swift
//
//
//  Created by Carson Katri on 7/4/23.
//

import Charts
import SwiftUI
import LiveViewNative

// this modifier is created by `liveview-client-swiftui`, and an implementation for Charts is provided here.
/// Set the corner radius of a mark.
///
/// Use this modifier on a mark to set the corner radius.
/// Optionally provide a ``style`` to use.
///
/// ```html
/// <BarMark modifiers={corner_radius(20, style: :circular)} ... />
/// ```
///
/// ## Arguments
/// * ``radius``
/// * ``style``
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
struct CornerRadiusModifier: ContentModifier {
    typealias Builder = ChartContentBuilder
    
    /// The corner radius.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private let radius: CGFloat
    
    /// The style of corner radius to apply. Defaults to `continuous`.
    ///
    /// See ``LiveViewNativeCharts/LiveViewNative/SwiftUI/RoundedCornerStyle`` for a list of possible values.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private let style: RoundedCornerStyle
    
    func apply<R: RootRegistry>(
        to content: Builder.Content,
        on element: ElementNode,
        in context: Builder.Context<R>
    ) -> Builder.Content {
        content.cornerRadius(radius, style: style)
    }
}
