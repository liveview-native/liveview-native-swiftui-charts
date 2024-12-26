//
//  AxisMarkBuilder.swift
//
//
//  Created by Carson Katri on 6/14/23.
//

import SwiftUI
import Charts
import LiveViewNative
import LiveViewNativeCore
import LiveViewNativeStylesheet

/// A builder for `AxisContent`.
struct AxisMarkBuilder: ContentBuilder {
    typealias Content = any AxisMark
    
    enum TagName: String {
        case axisGridLine = "AxisGridLine"
        case axisTick = "AxisTick"
        case axisValue = "AxisValue"
        case axisValueLabel = "AxisValueLabel"
    }
    
    enum ModifierType: ContentModifier {
        typealias Builder = AxisMarkBuilder
        
        case font(FontModifier)
        case foregroundStyle(AxisMarkForegroundStyleModifier)
        case offset(AxisMarkOffsetModifier)
        
        static func parser(in context: ParseableModifierContext) -> some Parser<Substring.UTF8View, Self> {
            OneOf {
                FontModifier.parser(in: context).map(Self.font)
                AxisMarkForegroundStyleModifier.parser(in: context).map(Self.foregroundStyle)
                AxisMarkOffsetModifier.parser(in: context).map(Self.offset)
            }
        }
        
        func apply<R>(
            to content: Builder.Content,
            on element: ElementNode,
            in context: Builder.Context<R>
        ) -> Builder.Content where R : RootRegistry {
            switch self {
            case let .font(modifier):
                modifier.apply(to: content, on: element, in: context)
            case let .foregroundStyle(modifier):
                modifier.apply(to: content, on: element, in: context)
            case let .offset(modifier):
                modifier.apply(to: content, on: element, in: context)
            }
        }
    }
    
    static func lookup<R: RootRegistry>(
        _ tag: TagName,
        element: ElementNode,
        context: Context<R>
    ) -> Content {
        switch tag {
        case .axisGridLine:
            return AxisGridLine(element: element).body
        case .axisTick:
            return AxisTick(element: element).body
        case .axisValue:
            return AxisValue(element: element, context: context).body
        case .axisValueLabel:
            return AxisValueLabel(element: element, context: context).body
        }
    }
    
    static func empty() -> Content {
        Charts.AxisMarkBuilder.buildBlock()
    }
    
    static func reduce(accumulated: Content, next: Content) -> Content {
        Charts.AxisMarkBuilder.buildPartialBlock(accumulated: accumulated, next: next)
    }
}

@MainActor
protocol ComposedAxisMark {
    associatedtype Body: AxisMark
    @Charts.AxisMarkBuilder
    var body: Body { get }
}
