//
//  BarMark.swift
//
//
//  Created by Carson Katri on 6/8/23.
//

import Charts
import LiveViewNative

struct BarMark: ChartContent {
    let element: ElementNode
    
    var body: some ChartContent {
        if let (xLabel, x) = element.plottable(named: "x"),
           let (yLabel, y) = element.plottable(named: "y")
        {
            unbox(
                x: xLabel, x,
                y: yLabel, y
            )
        }
    }
    
    func unbox(x xLabel: String, _ x: some Plottable, y yLabel: String, _ y: some Plottable) -> AnyChartContent {
        AnyChartContent(
            Charts.BarMark(
                x: .value(xLabel, x),
                y: .value(yLabel, y)
            )
        )
    }
}
