//
//  ChartContentTreeBuilder.swift
//
//
//  Created by Carson Katri on 6/8/23.
//

@_spi(LiveViewNative) import LiveViewNative
import LiveViewNativeCore
import Charts
import SwiftUI

/// A builder for `ChartContent`.
struct ChartContentTreeBuilder<R: RootRegistry> {
    @ChartContentBuilder
    func fromNodes<Nodes>(_ nodes: Nodes, context: LiveContextStorage<R>) -> some ChartContent
        where Nodes: RandomAccessCollection, Nodes.Index == Int, Nodes.Element == Node
    {
        ForEach(nodes, id: \.id) { node in
            fromNode(node, context: context)
        }
    }
    
    @ChartContentBuilder
    fileprivate func fromNode(_ node: Node, context: LiveContextStorage<R>) -> some ChartContent {
        switch node.data {
        case .root:
            fatalError("ViewTreeBuilder.fromNode may not be called with the root node")
        case .leaf:
            fatalError("ViewTreeBuilder.fromNode may not be called with a leaf node")
        case .element(let element):
            fromElement(ElementNode(node: node, data: element), context: context)
        }
    }
    
    fileprivate func fromElement(_ element: ElementNode, context: LiveContextStorage<R>) -> some ChartContent {
        let content = ChartElementRegistry<R>.lookup(element, context: context)
        let modifiers: [ModifierContainer<R>] = element.attributeValue(for: "modifiers")
            .flatMap({ try? makeJSONDecoder().decode([ModifierContainer<R>].self, from: Data($0.utf8)) })
            ?? []
        return content
            .applyModifiers(modifiers[...])
    }
}

extension ChartContent {
    @ChartContentBuilder
    func applyModifiers<R: RootRegistry>(_ modifiers: ArraySlice<ModifierContainer<R>>) -> some ChartContent {
        if let first = modifiers.first {
            AnyChartContent(
                first.modifier
                    .body(content: .init(self))
                    .applyModifiers(modifiers.dropFirst())
            )
        } else {
            self
        }
    }
}

struct ModifierContainer<R: RootRegistry>: Decodable {
    let modifier: ModifierRegistry<R>.BuiltinModifier
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.modifier = try ModifierRegistry<R>.decodeModifier(
            try container.decode(ModifierType.self, forKey: .type),
            from: decoder
        )
    }
    
    enum CodingKeys: CodingKey {
        case type
    }
}

enum ChartError: Error {
    case unknownTag(String)
}
