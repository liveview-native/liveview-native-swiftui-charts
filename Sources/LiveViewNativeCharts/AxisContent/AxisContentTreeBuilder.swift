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
struct AxisContentTreeBuilder<R: RootRegistry> {
    func fromNodes<Nodes>(_ nodes: Nodes, context: LiveContextStorage<R>) -> some AxisContent
        where Nodes: RandomAccessCollection, Nodes.Index == Int, Nodes.Element == Node
    {
        return nodes.reduce(AnyAxisContent(AxisContentBuilder.buildBlock())) {
            AnyAxisContent(AxisContentBuilder.buildPartialBlock(accumulated: $0, next: fromNode($1, context: context)))
        }
    }
    
    @AxisContentBuilder
    fileprivate func fromNode(_ node: Node, context: LiveContextStorage<R>) -> some AxisContent {
        switch node.data {
        case .root:
            fatalError("AxisContentTreeBuilder.fromNode may not be called with the root node")
        case .leaf:
            fatalError("AxisContentTreeBuilder.fromNode may not be called with a leaf node")
        case .element(let element):
            fromElement(ElementNode(node: node, data: element), context: context)
        }
    }
    
    fileprivate func fromElement(_ element: ElementNode, context: LiveContextStorage<R>) -> some AxisContent {
        return AxisElementRegistry<R>.lookupAxisContent(element, context: context)
    }
}

protocol ComposedAxisContent {
    associatedtype Body: AxisContent
    @AxisContentBuilder
    var body: Body { get }
}
