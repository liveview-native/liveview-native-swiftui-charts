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
/// <Chart modifiers={chart_legend(content: :my_legend)}>
///   ...
///   <Group template={:my_legend}>
///     ...
///   </Group>
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
    /// Possible values:
    /// * `automatic`
    /// * `visible`
    /// * `hidden`
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private let visibility: Visibility?
    
    /// The position of the legend.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private let position: AnnotationPosition
    
    /// The alignment of content within the legend.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private let alignment: Alignment?
    
    /// The spacing between the chart and the legend.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private let spacing: Double?
    
    /// A reference to the element to use as the legend.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private let content: String?
    
    @ObservedElement(observeChildren: true) private var element
    @ContentBuilderContext<R> private var context
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.visibility = try container.decodeIfPresent(Visibility.self, forKey: .visibility)
        self.position = try container.decode(AnnotationPosition.self, forKey: .position)
        self.alignment = try container.decodeIfPresent(Alignment.self, forKey: .alignment)
        self.spacing = try container.decodeIfPresent(Double.self, forKey: .spacing)
        self.content = try container.decodeIfPresent(String.self, forKey: .content)
    }
    
    func body(content: Content) -> some View {
        if let visibility {
            content.chartYAxis(visibility)
        } else if let template = self.content {
            content.chartYAxis {
                AnyAxisContent(
                    try! AxisContentBuilder.buildChildren(
                        of: element,
                        forTemplate: template,
                        in: context
                    )
                )
            }
        } else {
            content
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
