//
//  ChartsRegistry.swift
//
//
//  Created by Carson Katri on 6/8/23.
//

import LiveViewNative
import Charts
import SwiftUI

/// Swift Charts add-on library registry.
///
/// Include this registry in your `AggregateRegistry` to gain access to the ``Chart`` view.
public struct ChartsRegistry<Root: RootRegistry>: CustomRegistry {
    public enum TagName: String {
        case chart = "Chart"
    }
    
    public static func lookup(_ name: TagName, element: ElementNode) -> some View {
        switch name {
        case .chart:
            Chart<Root>()
        }
    }
    
    public enum ModifierType: String {
        case chartXAxis = "chart_x_axis"
        case chartXAxisLabel = "chart_x_axis_label"
        case chartYAxis = "chart_y_axis"
        case chartYAxisLabel = "chart_y_axis_label"
        case chartXScale = "chart_x_scale"
        case chartYScale = "chart_y_scale"
    }
    
    public static func decodeModifier(_ type: ModifierType, from decoder: Decoder) throws -> some ViewModifier {
        switch type {
        case .chartXAxis:
            try ChartXAxisModifier<Root>(from: decoder)
        case .chartXAxisLabel:
            try ChartXAxisLabelModifier<Root>(from: decoder)
        case .chartYAxis:
            try ChartYAxisModifier<Root>(from: decoder)
        case .chartYAxisLabel:
            try ChartYAxisLabelModifier<Root>(from: decoder)
        case .chartXScale:
            try ChartXScaleModifier(from: decoder)
        case .chartYScale:
            try ChartYScaleModifier(from: decoder)
        }
    }
}
