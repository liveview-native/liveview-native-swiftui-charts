//
//  ChartSymbolScaleModifier.swift
//
//
//  Created by Carson Katri on 6/27/23.
//

import Charts
import SwiftUI
import LiveViewNative

/// Configures the scale used for the symbol.
///
/// Provide a ``domain`` and/or ``range`` to configure the scale.
///
/// The ``domain`` provides the list or range of values to display along the axis.
///
/// See ``AnyScaleDomain`` for more details.
///
/// - Note: Only categorical values, such as an array of values, can be used as a symbol domain.
/// Ranges cannot be used.
///
/// ```html
/// <Chart modifiers={chart_symbol_scale(domain: ["A", "B", "C"])}>
///   ...
/// </Chart>
/// ```
///
/// The ``range``  sets the symbols that get used for each value in the domain.
///
/// See ``LiveViewNativeCharts/Charts/BasicChartSymbolShape`` for a list of possible values.
///
/// ```html
/// <Chart modifiers={chart_symbol_scale(range: [:circle, :asterisk, :plus])}>
///   ...
/// </Chart>
/// ```
///
/// The ``mapping`` can be used to customize the symbols for each category.
///
/// See ``LiveViewNativeCharts/Charts/BasicChartSymbolShape`` for a list of possible values.
///
/// - Note: If no ``domain`` is provided, the keys of the map are used as the domain.
/// In this case, the keys will be sorted alphabetically.
///
/// ```html
/// <Chart modifiers={chart_symbol_scale(mapping: %{
///   "A" => :circle,
///   "B" => :asterisk,
///   "C" => :plus
/// })}>
///   ...
/// </Chart>
/// ```
///
/// ## Arguments
/// * ``domain``
/// * ``range``
/// * ``mapping``
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
struct ChartSymbolScaleModifier: ViewModifier, Decodable {
    /// The range or values to use for the symbols.
    ///
    /// See ``AnyScaleDomain`` for more details.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private let domain: AnyScaleDomain?
    
    /// The range of symbols to use.
    ///
    /// See ``LiveViewNativeCharts/Charts/BasicChartSymbolShape`` for a list of possible values.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private let range: [BasicChartSymbolShape]?
    
    /// A mapping from plottable values to symbol shapes.
    ///
    /// Create a mapping between a string and a ``LiveViewNativeCharts/Charts/BasicChartSymbolShape``.
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
    private let mapping: [String:BasicChartSymbolShape]?
    
    struct Mapping: Decodable {
        let value: String
        let symbol: BasicChartSymbolShape
    }
    
    func body(content: Content) -> some View {
        if let mapping {
            if case let .some(.values(domain)) = domain {
                content.chartSymbolScale(domain: domain) { key in
                    mapping[key]!
                }
            } else {
                content.chartSymbolScale(domain: mapping.keys.sorted()) { key in
                    mapping[key]!
                }
            }
        } else {
            switch (domain, range) {
            case let (domain?, range?):
                content.chartSymbolScale(domain: domain, range: range)
            case let (domain?, nil):
                content.chartSymbolScale(domain: domain)
            case let (nil, range?):
                content.chartSymbolScale(range: range)
            case (nil, nil):
                content
            }
        }
    }
}
