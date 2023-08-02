//
//  ChartLegendModifier.swift
//
//
//  Created by Carson Katri on 7/4/23.
//

import Charts
import SwiftUI
import LiveViewNative

/// Configure a chart's legend.
///
/// Set the ``visibility`` to hide/show the legend.
///
/// ```html
/// <Chart modifiers={chart_legend(:hidden)}>
///   ...
/// </Chart>
/// ```
///
/// Use the ``position`` argument to configure the placement of the legend.
/// Optionally provide the ``alignment`` and ``spacing`` arguments to customize further.
///
/// ```html
/// <Chart modifiers={chart_legend(position: :trailing, spacing: 32)}>
///   ...
/// </Chart>
/// ```
///
/// Use the ``content`` argument to use custom Views for the legend.
/// Optionally provide the ``position``, ``alignment``, and ``spacing``.
///
/// ```html
/// <Chart modifiers={chart_legend(position: :leading, content: :my_legend)}>
///   ...
///   <VStack template={:my_legend}>
///     ...
///   </VStack>
/// </Chart>
/// ```
///
/// ## Arguments
/// * ``visibility``
/// * ``position``
/// * ``alignment``
/// * ``spacing``
/// * ``content``
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
struct ChartLegendModifier<R: RootRegistry>: ViewModifier, Decodable {
    /// The visibility of the axis.
    ///
    /// See ``LiveViewNativeCharts/LiveViewNative/SwiftUI/Visibility`` for a list of possible values.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private let visibility: Visibility?
    
    /// The position of the legend. Defaults to `automatic`.
    ///
    /// See ``LiveViewNativeCharts/Charts/AnnotationPosition`` for a list of possible values.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private let position: AnnotationPosition
    
    /// The alignment of the legend relative to the chart.
    ///
    /// See ``LiveViewNativeCharts/LiveViewNative/SwiftUI/Alignment`` for a list of possible values.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private let alignment: Alignment?
    
    /// The spacing between the chart and the legend.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private let spacing: CGFloat?
    
    /// A reference to the element to use as the legend.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private let content: String?
    
    @ObservedElement private var element
    @LiveContext<R> private var context
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.visibility = try container.decodeIfPresent(Visibility.self, forKey: .visibility)
        self.position = try container.decode(AnnotationPosition.self, forKey: .position)
        self.alignment = try container.decodeIfPresent(Alignment.self, forKey: .alignment)
        self.spacing = try container.decodeIfPresent(CGFloat.self, forKey: .spacing)
        self.content = try container.decodeIfPresent(String.self, forKey: .content)
    }
    
    func body(content: Content) -> some View {
        if let visibility {
            content.chartLegend(visibility)
        } else if let template = self.content {
            content.chartLegend(position: position, alignment: alignment, spacing: spacing) {
                context.buildChildren(of: element, forTemplate: template)
            }
        } else {
            content.chartLegend(position: position, alignment: alignment, spacing: spacing)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case visibility
        case position
        case alignment
        case spacing
        case content
    }
}
