//
//  Plot.swift
//
//
//  Created by Carson Katri on 6/13/23.
//

import Charts
import LiveViewNative

struct Plot<R: RootRegistry>: ChartContent {
    let element: ElementNode
    let context: ChartContentBuilder.Context<R>
    
    var body: some ChartContent {
        Charts.Plot {
            AnyChartContent(try! ChartContentBuilder.buildChildren(of: element, in: context))
        }
    }
}
