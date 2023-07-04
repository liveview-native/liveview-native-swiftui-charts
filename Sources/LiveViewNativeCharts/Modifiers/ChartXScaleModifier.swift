//
//  ChartXScaleModifier.swift
//
//
//  Created by Carson Katri on 6/20/23.
//

import Charts
import SwiftUI
import LiveViewNative

/// Configures the scale used for the x axis.
///
/// Provide a ``domain``, ``range``, and/or ``scaleType`` to configure the scale.
///
/// The ``domain`` provides the list or range of values to display along the axis.
///
/// For example, the domain `{1, 5}` will display the values from 1 through 5 on the axis.
/// The default domain is `:automatic`.
///
/// See ``AnyScaleDomain`` for more details.
///
/// ```html
/// <Chart modifiers={chart_x_scale(@native, domain: {1, 5})}>
///   ...
/// </Chart>
/// ```
///
/// The ``range`` can be used to add padding to the chart.
///
/// See ``LiveViewNativeCharts/Charts/PlotDimensionScaleRange`` for a list of possible values.
///
/// ```html
/// <Chart modifiers={chart_x_scale(@native, range: {:plot_dimension, [start_padding: 50]})>
///   ...
/// </Chart>
/// ```
///
/// The ``scaleType`` describes the type of scale to use, such as `linear`, `log`, `category`, etc.
///
/// ```html
/// <Chart modifiers={chart_x_scale(@native, domain: ["A", "B", "C"], type: :category)}>
///   ...
/// </Chart>
/// ```
/// 
/// ## Arguments
/// * ``domain``
/// * ``range``
/// * ``scaleType``
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
struct ChartXScaleModifier: ViewModifier, Decodable {
    /// The range or values to use along the axis.
    ///
    /// See ``AnyScaleDomain`` for more details.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private let domain: AnyScaleDomain?
    
    /// Apply padding to the start/end of the axis.
    ///
    /// See ``LiveViewNativeCharts/Charts/PlotDimensionScaleRange`` for a list of possible values.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private let range: PlotDimensionScaleRange?
    
    /// `scale_type`, the type of scale to use.
    ///
    /// See ``LiveViewNativeCharts/Charts/ScaleType`` for a list of possible values.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private let scaleType: ScaleType?
    
    func body(content: Content) -> some View {
        switch (domain, range) {
        case let (domain?, range?):
            content.chartXScale(domain: domain, range: range, type: scaleType)
        case let (domain?, nil):
            content.chartXScale(domain: domain, type: scaleType)
        case let (nil, range?):
            content.chartXScale(range: range, type: scaleType)
        case (nil, nil):
            content.chartXScale(type: scaleType)
        }
    }
}
