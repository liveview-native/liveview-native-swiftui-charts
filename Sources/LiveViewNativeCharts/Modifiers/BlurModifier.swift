//
//  BlurModifier.swift
//
//
//  Created by Carson Katri on 6/27/23.
//

import Charts
import SwiftUI
import LiveViewNative

/// Applies a Gaussian blur to the element.
///
/// Set the ``radius`` to control the strength of the blur.
///
/// ```html
/// <BarMark modifiers={blur(radius: 2)} ... />
/// ```
///
/// ## Arguments
/// * ``radius``
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
@available(iOS 16.4, macOS 13.3, tvOS 16.4, watchOS 9.4, *)
struct BlurModifier: ContentModifier {
    typealias Builder = ChartContentBuilder
    
    /// The strength of the blur.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private let radius: CGFloat
    
    func apply<R>(
        to content: Builder.Content,
        on element: ElementNode,
        in context: Builder.Context<R>
    ) -> Builder.Content where R : RootRegistry {
        return content.blur(radius: radius)
    }
}
