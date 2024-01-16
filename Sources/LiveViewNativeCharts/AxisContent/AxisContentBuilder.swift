//
//  AxisContentTreeBuilder.swift
//
//
//  Created by Carson Katri on 6/14/23.
//

import Charts
import LiveViewNative
import LiveViewNativeCore
import SwiftUI

/// A builder for `AxisContent`.
struct AxisContentBuilder: ContentBuilder {
    typealias Content = any AxisContent
    
    enum TagName: String {
        case axisMarks = "AxisMarks"
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
}

protocol ComposedAxisContent {
    associatedtype Body: AxisContent
    @Charts.AxisContentBuilder
    var body: Body { get }
}
