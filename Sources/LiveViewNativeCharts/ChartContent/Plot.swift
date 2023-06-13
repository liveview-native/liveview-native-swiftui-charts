//
//  Plot.swift
//
//
//  Created by Carson Katri on 6/13/23.
//

import Charts
@_spi(LiveViewNative) import LiveViewNative

struct Plot<R: RootRegistry>: ChartContent {
    let element: ElementNode
    let context: LiveContextStorage<R>
    
    var body: some ChartContent {
        Charts.Plot {
            ChartContentTreeBuilder().fromNodes(
                element.children().filter({
                    !$0.attributes.contains(where: { $0.name == "template" })
                }),
                context: context
            )
        }
    }
}
