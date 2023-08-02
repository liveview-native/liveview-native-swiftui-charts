//
//  AlignsMarkStylesWithPlotAreaModifier.swift
//
//
//  Created by Carson Katri on 7/5/23.
//

import Charts
import LiveViewNative

/// Align mark styles to the chart's plot area.
///
/// Use this modifier on a mark to apply styles with coordinates in the plot area, instead of in the mark's boundary.
///
/// For example, a mark that uses a gradient for its fill will start at the top of each mark.
/// With this modifier, the gradient will start at the top of the chart instead.
///
/// ```html
/// <BarMark modifiers={foreground_style(primary: ...) |> aligns_mark_styles_with_plot_area(true)} />
/// ```
/// ## Arguments
/// * ``aligns``
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
struct AlignsMarkStylesWithPlotAreaModifier: ContentModifier {
    typealias Builder = ChartContentBuilder
    
    /// Enables/disables the effect. Defaults to `true`.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    let aligns: Bool
    
    func apply<R: RootRegistry>(
        to content: Builder.Content,
        on element: ElementNode,
        in context: Builder.Context<R>
    ) -> Builder.Content {
        content.alignsMarkStylesWithPlotArea(aligns)
    }
}
