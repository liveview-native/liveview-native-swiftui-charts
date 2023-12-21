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
    
    public struct CustomModifier: ViewModifier, ParseableModifierValue {
        enum Storage {
            case chartBackground(ChartBackgroundModifier<Root>)
            case chartOverlay(ChartOverlayModifier<Root>)
            case chartXAxis(ChartXAxisModifier<Root>)
            case chartYAxis(ChartYAxisModifier<Root>)
            case noop
        }
        let storage: Storage
        
        public static func parser(in context: ParseableModifierContext) -> some Parser<Substring.UTF8View, Self> {
            CustomModifierGroupParser(output: Self.self) {
                ChartBackgroundModifier<Root>.parser(in: context).map({ Self(storage: .chartBackground($0)) })
                ChartOverlayModifier<Root>.parser(in: context).map({ Self(storage: .chartOverlay($0)) })
                ChartXAxisModifier<Root>.parser(in: context).map({ Self(storage: .chartXAxis($0)) })
                ChartYAxisModifier<Root>.parser(in: context).map({ Self(storage: .chartYAxis($0)) })
                ChartContentBuilder.ModifierType.parser(in: context).map({ _ in Self(storage: .noop) })
                AxisContentBuilder.ModifierType.parser(in: context).map({ _ in Self(storage: .noop) })
                AxisMarkBuilder.ModifierType.parser(in: context).map({ _ in Self(storage: .noop) })
            }
        }
        
        public func body(content: Content) -> some View {
            switch storage {
            case .chartBackground(let modifier):
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
