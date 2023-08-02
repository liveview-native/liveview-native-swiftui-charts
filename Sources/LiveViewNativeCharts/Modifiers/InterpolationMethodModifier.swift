//
//  OffsetModifier.swift
//
//
//  Created by Carson Katri on 6/28/23.
//

import Charts
import LiveViewNative

/// Set the interpolation method for ``LineMark`` and ``AreaMark``.
///
/// Customize the shape of area and line marks with different interpolation methods.
///
/// ```html
/// <LineMark modifiers={interpolation_method(:catmull_rom)} />
/// <AreaMark modifiers={interpolation_method(:cardinal)} />
/// ```
///
/// ## Arguments
/// * ``method``
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
struct InterpolationMethodModifier: ContentModifier {
    typealias Builder = ChartContentBuilder
    
    /// The interpolation method to use.
    /// 
    /// See ``LiveViewNativeCharts/Charts/InterpolationMethod`` for a list of possible values.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    let method: InterpolationMethod
    
    func apply<R: RootRegistry>(
        to content: Builder.Content,
        on element: ElementNode,
        in context: Builder.Context<R>
    ) -> Builder.Content {
        content.interpolationMethod(method)
    }
}
