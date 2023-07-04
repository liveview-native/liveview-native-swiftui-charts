//
//  ChartForegroundStyleScale.swift
//  
//
//  Created by murtza on 28/06/2023.
//

import Charts
import SwiftUI
import LiveViewNative

/// The ``mapping`` Maps data categories to foreground styles.
///
/// See ``LiveViewNativeCharts/LiveViewNative/SwiftUI/AnyShapeStyle`` for a list of possible values.
///
/// ```html
/// <Chart modifiers={chart_foreground_style_scale(mapping: %{
///     "A" => {:color, :blue},
///     "B" => {:opacity, 0.5}
/// })}>
///   ...
/// </Chart>
/// ```
///
/// The possible data values plotted as foreground style in the chart. You can define the ``domain`` with an array for categorical values (e.g., ["A", "B", "C"])
///
/// See ``LiveViewNativeCharts/Charts/AnyScaleDomain`` for more details.
///
/// ```html
/// <Chart modifiers={chart_foreground_style_scale(domain: ["A", "B", "C"])}>
///   ...
/// </Chart>
/// ```
///
/// The ``range`` of foreground styles that correspond to the scale domain.
///
/// See ``LiveViewNativeCharts/LiveViewNative/SwiftUI/AnyShapeStyle`` for a list of possible values.
///
/// ```html
/// <Chart modifiers={chart_foreground_style_scale(range: [:circle, :asterisk, :plus])}>
///   ...
/// </Chart>
/// ```
///
/// The ``type`` provides the ways you can scale the domain or range of a plot.
///
/// See ``LiveViewNativeCharts/Charts/ScaleType`` for a list of possible values.
///
/// ```html
/// <Chart modifiers={chart_foreground_style_scale(type: :category)}>
///   ...
/// </Chart>
/// ```
///
/// ## Arguments
/// * ``mapping``
/// * ``domain``
/// * ``range``
/// * ``type``
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
struct ChartForegroundStyleScaleModifier: ViewModifier, Decodable {
    /// The ``mapping`` Maps data categories to foreground styles.
    ///
    /// Create a mapping between a string and a ``LiveViewNativeCharts/LiveViewNative/SwiftUI/AnyShapeStyle``.
    ///
    /// ```elixir
    /// %{
    ///     "A" => :circle,
    ///     "B" => :asterisk,
    ///     "C" => :square
    /// }
    /// ```
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private let mapping: [String:AnyShapeStyle]?

    struct Mapping: Decodable {
        let value: String
        let symbol: AnyShapeStyle
    }
    
    /// The possible data values plotted as foreground style in the chart.
    ///
    /// See ``LiveViewNativeCharts/Charts/AnyScaleDomain`` for more details.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private let domain: AnyScaleDomain?

    /// The ``range`` of foreground styles that correspond to the scale domain.
    ///
    /// See ``LiveViewNativeCharts/Charts/BasicChartSymbolShape`` for a list of possible values.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private let range: [BasicChartSymbolShape]?
    
    /// The scale type.
    ///
    /// See ``LiveViewNativeCharts/Charts/ScaleType`` for a list of possible values.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private let type: ScaleType?

    func body(content: Content) -> some View {
        if let mapping {
            if case let .some(.values(domain)) = domain {
                content.chartForegroundStyleScale(domain: domain) { key in
                    mapping[key]!
                }
            } else {
                content.chartForegroundStyleScale(domain: mapping.keys.sorted()) { key in
                    mapping[key]!
                }
            }
        } else {
            switch (domain, range, type) {
            case let (domain?, range?, type?):
                content.chartForegroundStyleScale(domain: domain, range: range, type: type)
            case let (domain?, nil, type?):
                content.chartForegroundStyleScale(domain: domain, type: type)
            case let (nil, range?, type?):
                content.chartForegroundStyleScale(range: range, type: type)
            case (nil, nil, type?):
                content.chartForegroundStyleScale(type: type)
            case (nil, nil, nil):
                content
            }
        }
    }
}
