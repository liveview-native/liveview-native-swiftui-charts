//
//  RuleMark.swift
//
//
//  Created by Carson Katri on 6/13/23.
//

import Charts
import LiveViewNative

struct RuleMark: ChartContent {
    let element: ElementNode
    
    var body: some ChartContent {
        if let (xLabel, x) = element.plottable(named: "x"),
           let (yStartLabel, yStart) = element.plottable(named: "y-start"),
           let (yEndLabel, yEnd) = element.plottable(named: "y-end")
        {
            unbox(
                x: xLabel, x,
                yStart: yStartLabel, yStart,
                yEnd: yEndLabel, yEnd
            )
        } else if let (yLabel, y) = element.plottable(named: "y"),
                  let (xStartLabel, xStart) = element.plottable(named: "x-start"),
                  let (xEndLabel, xEnd) = element.plottable(named: "x-end")
        {
            unbox(
                y: yLabel, y,
                xStart: xStartLabel, xStart,
                xEnd: xEndLabel, xEnd
            )
        } else if let (xLabel, x) = element.plottable(named: "x") {
            unbox(x: xLabel, x)
        } else if let (yLabel, y) = element.plottable(named: "y") {
            unbox(y: yLabel, y)
        }
    }
    
    func unbox<T: Plottable>(
        x xLabel: String, _ x: some Plottable,
        yStart yStartLabel: String, _ yStart: T,
        yEnd yEndLabel: String, _ yEnd: some Plottable
    ) -> AnyChartContent {
        AnyChartContent(
            Charts.RuleMark(
                x: .value(xLabel, x),
                yStart: .value(yStartLabel, yStart),
                yEnd: .value(yEndLabel, yEnd as! T)
            )
        )
    }
    
    func unbox<T: Plottable>(
        y yLabel: String, _ y: some Plottable,
        xStart xStartLabel: String, _ xStart: T,
        xEnd xEndLabel: String, _ xEnd: some Plottable
    ) -> AnyChartContent {
        AnyChartContent(
            Charts.RuleMark(
                xStart: .value(xStartLabel, xStart),
                xEnd: .value(xEndLabel, xEnd as! T),
                y: .value(yLabel, y)
            )
        )
    }
    
    func unbox(
        x xLabel: String, _ x: some Plottable
    ) -> AnyChartContent {
        AnyChartContent(
            Charts.RuleMark(
                x: .value(xLabel, x)
            )
        )
    }
    
    func unbox(
        y yLabel: String, _ y: some Plottable
    ) -> AnyChartContent {
        AnyChartContent(
            Charts.RuleMark(
                y: .value(yLabel, y)
            )
        )
    }
}
