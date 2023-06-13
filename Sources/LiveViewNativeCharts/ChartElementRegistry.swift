//
//  ChartElementRegistry.swift
//
//
//  Created by Carson Katri on 6/13/23.
//

import Charts
@_spi(LiveViewNative) import LiveViewNative

enum ChartElementRegistry<R: RootRegistry> {
    @ChartContentBuilder
    static func lookup(_ node: ElementNode, context: LiveContextStorage<R>) -> some ChartContent {
        switch node.tag {
        case "BarMark":
            BarMark<R>(element: node)
        case "Plot":
            Plot<R>(element: node, context: context)
        default:
            fatalError(ChartError.unknownTag(node.tag).localizedDescription)
        }
    }
}
