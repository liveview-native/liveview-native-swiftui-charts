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
        case barMark = "BarMark"
        case plot = "Plot"
    }
    
    enum ModifierType: String, Decodable {
        case foregroundStyle = "foreground_style"
        case offset
    }
    
    static func lookup<R: RootRegistry>(
        _ tag: TagName,
        element: ElementNode,
        context: Context<R>
    ) -> Content {
        switch tag {
        case .barMark:
            return BarMark(element: element)
        case .plot:
            return Plot<R>(element: element, context: context)
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
        case .offset:
            return try OffsetModifier(from: decoder)
        }
    }
}
