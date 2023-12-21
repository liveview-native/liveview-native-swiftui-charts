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
    
    enum ModifierType: ContentModifier {
        typealias Builder = ChartContentBuilder
        
        case alignsMarkStylesWithPlotArea(AlignsMarkStylesWithPlotAreaModifier)
        case cornerRadius(CornerRadiusModifier)
        case foregroundStyle(ForegroundStyleModifier)
        case interpolationMethod(InterpolationMethodModifier)
        case offset(OffsetModifier)
        case symbol(SymbolModifier)
        case symbolSize(SymbolSizeModifier)
        case zIndex(ZIndexModifier)
        
        static func parser(in context: ParseableModifierContext) -> some Parser<Substring.UTF8View, Self> {
            OneOf {
                AlignsMarkStylesWithPlotAreaModifier.parser(in: context).map(Self.alignsMarkStylesWithPlotArea)
                CornerRadiusModifier.parser(in: context).map(Self.cornerRadius)
                ForegroundStyleModifier.parser(in: context).map(Self.foregroundStyle)
                InterpolationMethodModifier.parser(in: context).map(Self.interpolationMethod)
                OffsetModifier.parser(in: context).map(Self.offset)
                SymbolModifier.parser(in: context).map(Self.symbol)
                SymbolSizeModifier.parser(in: context).map(Self.symbolSize)
                ZIndexModifier.parser(in: context).map(Self.zIndex)
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
