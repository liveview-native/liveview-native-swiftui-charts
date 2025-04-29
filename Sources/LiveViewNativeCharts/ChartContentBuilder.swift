//
//  ChartContentTreeBuilder.swift
//
//
//  Created by Carson Katri on 6/8/23.
//

import LiveViewNative
import LiveViewNativeStylesheet
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
    
    enum ModifierType: ContentModifier, @preconcurrency Decodable {
        typealias Builder = ChartContentBuilder
        
        case alignsMarkStylesWithPlotArea(AlignsMarkStylesWithPlotAreaModifier)
        case cornerRadius(CornerRadiusModifier)
        case foregroundStyle(ForegroundStyleModifier)
        case interpolationMethod(InterpolationMethodModifier)
        case offset(OffsetModifier)
        case symbol(SymbolModifier)
        case symbolSize(SymbolSizeModifier)
        case zIndex(ZIndexModifier)
        
        init(from decoder: any Decoder) throws {
            let container = try decoder.singleValueContainer()
            
            if let modifier = try? container.decode(AlignsMarkStylesWithPlotAreaModifier.self) {
                self = .alignsMarkStylesWithPlotArea(modifier)
            } else if let modifier = try? container.decode(CornerRadiusModifier.self) {
                self = .cornerRadius(modifier)
            } else if let modifier = try? container.decode(ForegroundStyleModifier.self) {
                self = .foregroundStyle(modifier)
            } else if let modifier = try? container.decode(InterpolationMethodModifier.self) {
                self = .interpolationMethod(modifier)
            } else if let modifier = try? container.decode(OffsetModifier.self) {
                self = .offset(modifier)
            } else if let modifier = try? container.decode(SymbolModifier.self) {
                self = .symbol(modifier)
            } else if let modifier = try? container.decode(SymbolSizeModifier.self) {
                self = .symbolSize(modifier)
            } else {
                self = .zIndex(try container.decode(ZIndexModifier.self))
            }
        }
        
        func apply<R>(
            to content: Builder.Content,
            on element: ElementNode,
            in context: Builder.Context<R>
        ) -> Builder.Content where R : RootRegistry {
            switch self {
            case let .alignsMarkStylesWithPlotArea(modifier):
                return modifier.apply(to: content, on: element, in: context)
            case let .cornerRadius(modifier):
                return modifier.apply(to: content, on: element, in: context)
            case let .foregroundStyle(modifier):
                return modifier.apply(to: content, on: element, in: context)
            case let .interpolationMethod(modifier):
                return modifier.apply(to: content, on: element, in: context)
            case let .offset(modifier):
                return modifier.apply(to: content, on: element, in: context)
            case let .symbol(modifier):
                return modifier.apply(to: content, on: element, in: context)
            case let .symbolSize(modifier):
                return modifier.apply(to: content, on: element, in: context)
            case let .zIndex(modifier):
                return modifier.apply(to: content, on: element, in: context)
            }
        }
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
}
