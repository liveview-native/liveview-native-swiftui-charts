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
    }
    
    public static func decodeModifier(_ type: ModifierType, from decoder: Decoder) throws -> some ViewModifier {
        switch type {
        case .chartXAxis:
            try ChartXAxisModifier<Root>(from: decoder)
        }
    }
}
