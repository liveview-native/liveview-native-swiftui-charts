//
//  Chart.swift
//
//
//  Created by Carson Katri on 6/8/23.
//

import SwiftUI
@_spi(LiveViewNative) import LiveViewNative
import Charts

public struct Chart<R: RootRegistry>: View {
    @ObservedElement private var element
    @LiveContext<R> private var context
    
    public var body: some View {
        Charts.Chart {
            ChartContentTreeBuilder().fromNodes(
                element.children().filter({
                    !$0.attributes.contains(where: { $0.name == "template" })
                }),
                context: context.storage
            )
        }
    }
}
