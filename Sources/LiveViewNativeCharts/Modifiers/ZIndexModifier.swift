//
//  ZIndexModifier.swift
//
//
//  Created by Carson Katri on 7/5/23.
//

import Charts
import LiveViewNative

// this modifier is created by `liveview-client-swiftui`, and an implementation for Charts is provided here.
/// Set the Z order of a mark.
///
/// Use this modifier on a mark to set its order when content overlaps.
///
/// ```html
/// <BarMark modifiers={z_index(2)} />
/// ```
///
/// ## Arguments
/// * ``value``
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
@available(iOS 17, macOS 14, tvOS 17, watchOS 10, *)
struct ZIndexModifier: ContentModifier {
    typealias Builder = ChartContentBuilder
    
    /// The Z order.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    let value: Double
    
    func apply<R: RootRegistry>(
        to content: Builder.Content,
        on element: ElementNode,
        in context: Builder.Context<R>
    ) -> Builder.Content {
        content.zIndex(value)
    }
}
