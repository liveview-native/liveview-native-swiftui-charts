//
//  Plot.swift
//
//
//  Created by Carson Katri on 6/13/23.
//

import Charts
import LiveViewNative

/// A container that groups multiple marks together.
///
/// Any modifiers applied to the plot will be applied to each child.
///
/// ```html
/// <Plot>
///   <BarMark ... />
///   <RuleMark ... />
/// </Plot>
/// ```
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
struct Plot<R: RootRegistry>: ChartContent {
    let element: ElementNode
    let context: ChartContentBuilder.Context<R>
    
    var body: some ChartContent {
        Charts.Plot {
            AnyChartContent(try! ChartContentBuilder.buildChildren(of: element, in: context))
        }
    }
}
