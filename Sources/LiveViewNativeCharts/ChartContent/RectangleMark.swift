//
//  RectangleMark.swift
//
//
//  Created by Carson Katri on 6/13/23.
//

import Charts
import LiveViewNative

struct RectangleMark: ChartContent {
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
            Charts.RectangleMark(
                x: .value(xLabel, x),
                y: .value(yLabel, y)
            )
        )
    }
}
