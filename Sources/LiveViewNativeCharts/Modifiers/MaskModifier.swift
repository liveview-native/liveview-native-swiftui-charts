//
//  MaskModifier.swift
//
//
//  Created by Carson Katri on 6/27/23.
//

import Charts
import LiveViewNative

// this modifier is created by `liveview-client-swiftui`, and an implementation for Charts is provided here.
/// Masks this chart content using the alpha channel of the given chart content.
///
/// ```html
/// <RectangleMark
///   modifiers={mask(content: :my_mask)}
///   x-start={0} x-start:label=" "
///   x-end={10} x-end:label=" "
/// >
///   <AreaMark
///     template={:my_mask}
///     :for={item <- 0..10}
///     x={item} x:label="Time"
///     y={item} y:label="Value"
///   />
/// </RectangleMark>
/// ```
///
/// ## Arguments
/// * ``content``
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
struct MaskModifier: ContentModifier {
    typealias Builder = ChartContentBuilder
    
    /// The content to use as the mask.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    let content: String
    
    func apply<R: RootRegistry>(
        to content: Builder.Content,
        on element: ElementNode,
        in context: Builder.Context<R>
    ) -> Builder.Content {
        content.mask {
            AnyChartContent(try! Builder.buildChildren(of: element, forTemplate: self.content, in: context))
        }
    }
}
