//
//  AxisMarkBuilder.swift
//
//
//  Created by Carson Katri on 6/14/23.
//

import Charts
@_spi(LiveViewNative) import LiveViewNative
import LiveViewNativeCore
import SwiftUI

/// A builder for `AxisContent`.
struct AxisMarkBuilder: ContentBuilder {
    typealias Content = any AxisMark
    
    enum TagName: String {
        case axisGridLine = "AxisGridLine"
    }
    
    enum ModifierType: String, Decodable {
        case font
        case foregroundStyle = "foreground_style"
        case offset
    }
    
    static func lookup<R: RootRegistry>(
        _ tag: TagName,
        element: ElementNode,
        context: Context<R>
    ) -> Content {
        switch tag {
        case .axisGridLine:
            return AxisGridLine(element: element).body
        }
    }
    
    static func empty() -> Content {
        Charts.AxisMarkBuilder.buildBlock()
    }
    
    static func reduce(accumulated: Content, next: Content) -> Content {
        Charts.AxisMarkBuilder.buildPartialBlock(accumulated: accumulated, next: next)
    }
    
    static func decodeModifier<R: RootRegistry>(
        _ type: ModifierType,
        from decoder: Decoder,
        registry _: R.Type
    ) throws -> any ContentModifier<Self> {
        switch type {
        case .font:
            return try FontModifier(from: decoder)
        case .foregroundStyle:
            return try AxisMarkForegroundStyleModifier(from: decoder)
        case .offset:
            return try AxisMarkOffsetModifier(from: decoder)
        }
    }
}

protocol ComposedAxisMark {
    associatedtype Body: AxisMark
    @Charts.AxisMarkBuilder
    var body: Body { get }
}
