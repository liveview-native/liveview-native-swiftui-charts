//
//  OpacityModifier.swift
//  
//
//  Created by Carson Katri on 6/23/23.
//

import Charts
import LiveViewNative

// this modifier is created by `liveview-client-swiftui`, and an implementation for Charts is provided here.
/// Set the opacity for chart content.
///
/// Use this modifier on a mark to set its opacity.
///
/// ```html
/// <BarMark modifiers={opacity(0.5)} />
/// ```
///
/// ## Arguments
/// * ``opacity``
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
struct OpacityModifier: ContentModifier {
    typealias Builder = ChartContentBuilder
    
    /// The opacity to apply.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    let opacity: Double
    
    func apply<R: RootRegistry>(
        to content: Builder.Content,
        on element: ElementNode,
        in context: Builder.Context<R>
    ) -> Builder.Content {
        content.opacity(opacity)
    }
}
