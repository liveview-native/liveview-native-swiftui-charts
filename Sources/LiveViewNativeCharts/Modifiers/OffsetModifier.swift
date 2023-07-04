//
//  OffsetModifier.swift
//
//
//  Created by Carson Katri on 6/8/23.
//

import Charts
import LiveViewNative

// this modifier is created by `liveview-client-swiftui`, and an implementation for Charts is provided here.
/// Offset a mark or axis.
///
/// Use this modifier on a mark to offset it.
///
/// ```html
/// <BarMark modifiers={offset(@native, x: 50)} />
/// ```
///
/// Use this modifier on an axis mark to offset it.
///
/// ```html
/// <AxisGridLine modifiers={offset(@native, y: 50)} />
/// ```
///
/// ## Arguments
/// * ``x``
/// * ``y``
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
struct OffsetModifier: ContentModifier {
    typealias Builder = ChartContentBuilder
    
    /// The horizontal offset
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    let x: Double?
    
    /// The vertical offset.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    let y: Double?
    
    /// The vertical offset.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    let xStart: Double?
    
    /// The vertical offset.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    let xEnd: Double?
    
    /// The vertical offset.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    let yStart: Double?
    
    /// The vertical offset.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    let yEnd: Double?
    
    func apply<R: RootRegistry>(
        to content: Builder.Content,
        on element: ElementNode,
        in context: Builder.Context<R>
    ) -> Builder.Content {
        if (xStart != nil || xEnd != nil) && (yStart != nil || yEnd != nil) {
            return content.offset(xStart: xStart ?? 0, xEnd: xEnd ?? 0, yStart: yStart ?? 0, yEnd: yEnd ?? 0)
        } else if yStart != nil || yEnd != nil {
            return content.offset(x: x ?? 0, yStart: yStart ?? 0, yEnd: yEnd ?? 0)
        } else if xStart != nil || xEnd != nil {
            return content.offset(xStart: xStart ?? 0, xEnd: xEnd ?? 0, y: y ?? 0)
        } else {
            return content.offset(x: x ?? 0, y: y ?? 0)
        }
    }
}

struct AxisMarkOffsetModifier: ContentModifier {
    typealias Builder = AxisMarkBuilder
    
    let x: Double?
    let y: Double?
    
    func apply<R: RootRegistry>(
        to content: Builder.Content,
        on element: ElementNode,
        in context: Builder.Context<R>
    ) -> Builder.Content {
        content.offset(x: x ?? 0, y: y ?? 0)
    }
}
