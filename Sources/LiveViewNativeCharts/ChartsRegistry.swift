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
}

enum ModifierType: String, Codable {
    case offset
    case foregroundStyle = "foreground_style"
}

enum ModifierRegistry<R: RootRegistry>: ModifierRegistryProtocol {
    @ChartModifierBuilder
    static func decodeModifier(_ type: ModifierType, from decoder: Decoder) throws -> some ChartModifier {
        switch type {
        case .offset:
            try OffsetModifier(from: decoder)
        case .foregroundStyle:
            try ForegroundStyleModifier(from: decoder)
        }
    }
}

protocol ModifierRegistryProtocol {
    associatedtype BuiltinModifier: ChartModifier
    static func decodeModifier(_ type: ModifierType, from decoder: Decoder) throws -> BuiltinModifier
}
