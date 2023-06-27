//
//  ChartContentTreeBuilder.swift
//
//
//  Created by Carson Katri on 6/8/23.
//

import LiveViewNative
import LiveViewNativeCore
import Charts
import SwiftUI

/// A builder for `ChartContent`.
struct ChartContentBuilder: ContentBuilder {
    typealias Content = any ChartContent
    
    enum TagName: String {
        case areaMark = "AreaMark"
        case barMark = "BarMark"
        case lineMark = "LineMark"
        case plot = "Plot"
        case pointMark = "PointMark"
        case rectangleMark = "RectangleMark"
        case ruleMark = "RuleMark"
    }
    
    enum ModifierType: String, Decodable {
        case foregroundStyle = "foreground_style"
        case mask
        case offset
        case opacity
        case symbol
    }
    
    static func lookup<R: RootRegistry>(
        _ tag: TagName,
        element: ElementNode,
        context: Context<R>
    ) -> Content {
        switch tag {
        case .areaMark:
            return AnyMark<AreaMark>(element: element)
        case .barMark:
            return AnyMark<BarMark>(element: element)
        case .lineMark:
            return AnyMark<LineMark>(element: element)
        case .plot:
            return Plot<R>(element: element, context: context)
        case .pointMark:
            return AnyMark<PointMark>(element: element)
        case .rectangleMark:
            return AnyMark<RectangleMark>(element: element)
        case .ruleMark:
            return AnyMark<RuleMark>(element: element)
        }
    }
    
    static func empty() -> Content {
        Charts.ChartContentBuilder.buildBlock()
    }
    
    static func reduce(accumulated: Content, next: Content) -> Content {
        Charts.ChartContentBuilder.buildPartialBlock(accumulated: accumulated, next: next)
    }
    
    static func decodeModifier<R: RootRegistry>(
        _ type: ModifierType,
        from decoder: Decoder,
        registry _: R.Type
    ) throws -> any ContentModifier<Self> {
        switch type {
        case .foregroundStyle:
            return try ForegroundStyleModifier(from: decoder)
        case .mask:
            return try MaskModifier(from: decoder)
        case .offset:
            return try OffsetModifier(from: decoder)
        case .opacity:
            return try OpacityModifier(from: decoder)
        case .symbol:
            return try SymbolModifier(from: decoder)
        }
    }
}
