//
//  AxisContentTreeBuilder.swift
//
//
//  Created by Carson Katri on 6/14/23.
//

import Charts
@_spi(LiveViewNative) import LiveViewNative
import LiveViewNativeCore
import SwiftUI

/// A builder for `AxisContent`.
struct AxisContentBuilder: ContentBuilder {
    typealias Content = any AxisContent
    
    enum TagName: String {
        case axisMarks = "AxisMarks"
    }
    
    struct ModifierType: RawRepresentable, Decodable {
        var rawValue: String
        
        init?(rawValue: String) {
            self.rawValue = rawValue
        }
    }
    
    static func lookup<R: RootRegistry>(
        _ tag: TagName,
        element: ElementNode,
        context: Context<R>
    ) -> Content {
        switch tag {
        case .axisMarks:
            return AxisMarks<R>(element: element, context: context).body
        }
    }
    
    static func empty() -> Content {
        Charts.AxisContentBuilder.buildBlock()
    }
    
    static func reduce(accumulated: Content, next: Content) -> Content {
        Charts.AxisContentBuilder.buildPartialBlock(accumulated: accumulated, next: next)
    }
    
    static func decodeModifier<R: RootRegistry>(
        _ type: ModifierType,
        from decoder: Decoder,
        registry _: R.Type
    ) throws -> any ContentModifier<Self> {
        fatalError()
    }
}

protocol ComposedAxisContent {
    associatedtype Body: AxisContent
    @Charts.AxisContentBuilder
    var body: Body { get }
}
