//
//  ChartsRegistry.swift
//
//
//  Created by Carson Katri on 6/8/23.
//

import Charts
import SwiftUI
import LiveViewNative
import LiveViewNativeStylesheet

public extension Addons {
    /// Swift Charts add-on library registry.
    ///
    /// Include this registry in your `AggregateRegistry` to gain access to the ``Chart`` view.
    @Addon
    public struct Charts<Root: RootRegistry> {
        public enum TagName: String {
            case chart = "Chart"
        }
        
        @MainActor
        public static func lookup(_ name: TagName, element: ElementNode) -> some View {
            switch name {
            case .chart:
                Chart<Root>()
            }
        }
        
        public struct CustomModifier: ViewModifier, @preconcurrency Decodable {
            enum Storage {
                case chartBackground(ChartBackgroundModifier<Root>)
                case chartLegend(ChartLegendModifier<Root>)
                case chartOverlay(ChartOverlayModifier<Root>)
                case chartXAxis(ChartXAxisModifier<Root>)
                case chartYAxis(ChartYAxisModifier<Root>)
                case noop
            }
            let storage: Storage
            
            public init(from decoder: any Decoder) throws {
                let container = try decoder.singleValueContainer()
                
                if let modifier = try? container.decode(ChartBackgroundModifier<Root>.self) {
                    self.storage = .chartBackground(modifier)
                } else if let modifier = try? container.decode(ChartLegendModifier<Root>.self) {
                    self.storage = .chartLegend(modifier)
                } else if let modifier = try? container.decode(ChartOverlayModifier<Root>.self) {
                    self.storage = .chartOverlay(modifier)
                } else if let modifier = try? container.decode(ChartXAxisModifier<Root>.self) {
                    self.storage = .chartXAxis(modifier)
                } else {
                    self.storage = .chartYAxis(try container.decode(ChartYAxisModifier<Root>.self))
                }
            }
            
            public func body(content: Content) -> some View {
                switch storage {
                case .chartBackground(let modifier):
                    content.modifier(modifier)
                case .chartLegend(let modifier):
                    content.modifier(modifier)
                case .chartOverlay(let modifier):
                    content.modifier(modifier)
                case .chartXAxis(let modifier):
                    content.modifier(modifier)
                case .chartYAxis(let modifier):
                    content.modifier(modifier)
                case .noop:
                    content
                }
            }
        }
    }
}
