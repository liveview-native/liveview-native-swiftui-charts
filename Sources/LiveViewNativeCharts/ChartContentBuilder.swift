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
        case alignsMarkStylesWithPlotArea = "aligns_mark_styles_with_plot_area"
        case cornerRadius = "corner_radius"
        case foregroundStyle = "foreground_style"
        case interpolationMethod = "interpolation_method"
        case offset
        case position
        case symbol
        case symbolSize = "symbol_size"
        case zIndex = "z_index"
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
        case .alignsMarkStylesWithPlotArea:
            return try AlignsMarkStylesWithPlotAreaModifier(from: decoder)
        case .cornerRadius:
            return try CornerRadiusModifier(from: decoder)
        case .foregroundStyle:
            return try ForegroundStyleModifier(from: decoder)
        case .interpolationMethod:
            return try InterpolationMethodModifier(from: decoder)
        case .offset:
            return try OffsetModifier(from: decoder)
        case .position:
            return try PositionModifier(from: decoder)
        case .symbol:
            return try SymbolModifier(from: decoder)
        case .symbolSize:
            return try SymbolSizeModifier(from: decoder)
        case .zIndex:
            if #available(iOS 17, macOS 14, tvOS 17, watchOS 10, *) {
                return try ZIndexModifier(from: decoder)
            } else {
                return EmptyContentModifier()
            }
        }
    }
}
