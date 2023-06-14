//
//  AxisMarkTreeBuilder.swift
//
//
//  Created by Carson Katri on 6/14/23.
//

import Charts
@_spi(LiveViewNative) import LiveViewNative
import LiveViewNativeCore
import SwiftUI

/// A builder for `AxisContent`.
struct AxisMarkTreeBuilder<R: RootRegistry> {
    func fromNodes<Nodes>(_ nodes: Nodes, context: LiveContextStorage<R>) -> some AxisMark
        where Nodes: RandomAccessCollection, Nodes.Index == Int, Nodes.Element == Node
    {
        return nodes.reduce(AnyAxisMark(AxisMarkBuilder.buildBlock())) {
            AnyAxisMark(AxisMarkBuilder.buildPartialBlock(accumulated: $0, next: fromNode($1, context: context)))
        }
    }
    
    @AxisMarkBuilder
    fileprivate func fromNode(_ node: Node, context: LiveContextStorage<R>) -> some AxisMark {
        switch node.data {
        case .root:
            fatalError("AxisMarkTreeBuilder.fromNode may not be called with the root node")
        case .leaf:
            fatalError("AxisMarkTreeBuilder.fromNode may not be called with a leaf node")
        case .element(let element):
            fromElement(ElementNode(node: node, data: element), context: context)
        }
    }
    
    fileprivate func fromElement(_ element: ElementNode, context: LiveContextStorage<R>) -> some AxisMark {
        let content = AxisElementRegistry<R>.lookupAxisMark(element, context: context)
        let modifiers: [AxisMarkModifierContainer<R>] = element.attributeValue(for: "modifiers")
            .flatMap({ try? makeJSONDecoder().decode([AxisMarkModifierContainer<R>].self, from: Data($0.utf8)) })
            ?? []
        return content
            .applyModifiers(modifiers[...])
    }
}

protocol ComposedAxisMark {
    associatedtype Body: AxisMark
    @AxisMarkBuilder
    var body: Body { get }
}

extension AxisMark {
    @AxisMarkBuilder
    func applyModifiers<R: RootRegistry>(_ modifiers: ArraySlice<AxisMarkModifierContainer<R>>) -> some AxisMark {
        if let first = modifiers.first {
            AnyAxisMark(
                first.modifier
                    .body(content: .init(self))
                    .applyModifiers(modifiers.dropFirst())
            )
        } else {
            self
        }
    }
}

struct AxisMarkModifierContainer<R: RootRegistry>: Decodable {
    let modifier: AxisMarkModifierRegistry<R>.BuiltinModifier
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.modifier = try AxisMarkModifierRegistry<R>.decodeModifier(
            try container.decode(AxisMarkModifierType.self, forKey: .type),
            from: decoder
        )
    }
    
    enum CodingKeys: CodingKey {
        case type
    }
}
