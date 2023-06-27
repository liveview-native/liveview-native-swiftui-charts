//
//  PlotDimensionScaleRange.swift
//
//
//  Created by Carson Katri on 6/20/23.
//

import Charts

/// A range used with the ``ChartXScaleModifier`` or ``ChartYScaleModifier`` modifiers.
///
/// Use this range to add padding to the start and/or end of an axis.
///
/// A tuple is used to represent the range.
/// The first element is the type of range, and the second element is any arguments.
///
/// Provide the `start_padding` and `end_padding` options to configure the padding
/// independently for each edge.
///
/// ```elixir
/// :plot_dimension # use default padding
/// {:plot_dimension, 10} # pad both sides 10 points
/// {:plot_dimension, [start_padding: 50]}
/// {:plot_dimension, [start_padding: 50, end_padding: 30]}
/// ```
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
extension PlotDimensionScaleRange: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let padding = try container.decodeIfPresent(Double.self, forKey: .padding) {
            self = .plotDimension(padding: padding)
        } else {
            let startPadding = try container.decodeIfPresent(Double.self, forKey: .startPadding)
            let endPadding = try container.decodeIfPresent(Double.self, forKey: .endPadding)
            switch (startPadding, endPadding) {
            case let (startPadding?, endPadding?):
                self = .plotDimension(startPadding: startPadding, endPadding: endPadding)
            case let (startPadding?, nil):
                self = .plotDimension(startPadding: startPadding)
            case let (nil, endPadding?):
                self = .plotDimension(endPadding: endPadding)
            case (nil, nil):
                self = .plotDimension
            }
        }
    }
    
    enum CodingKeys: CodingKey {
        case padding
        case startPadding
        case endPadding
    }
}
