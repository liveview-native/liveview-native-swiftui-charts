//
//  ChartPlotStyleModifier.swift
//
//
//  Created by Carson Katri on 6/29/23.
//

import Charts
import SwiftUI
import LiveViewNative

/// Style the chart's plot with modifiers.
///
/// Pass any modifiers that should be applied to the plot to the ``modifiers`` argument.
///
/// ```html
/// <Chart modifiers={chart_plot_style(aspect_ratio(1, content_mode: :fit) |> frame(width: 200))}>
///   ...
/// </Chart>
/// ```
///
/// ## Arguments
/// * ``modifiers``
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
struct ChartPlotStyleModifier<R: RootRegistry>: ViewModifier, Decodable {
    /// The modifier stack to apply to the plot.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private let modifiers: [ModifierContainer<R>]
    
    @ObservedElement private var element
    @LiveContext<R> private var context
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.modifiers = try container.decode([ModifierContainer<R>].self, forKey: .modifiers)
    }
    
    func body(content: Content) -> some View {
        content
            .chartPlotStyle { content in
                content
                    ._applyModifiers(modifiers[...], element: element, context: context)
            }
    }
    
    enum CodingKeys: CodingKey {
        case modifiers
    }
}
