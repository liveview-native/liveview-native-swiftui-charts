//
//  ForegroundStyleModifier.swift
//
//
//  Created by Carson Katri on 6/8/23.
//

import Charts

struct ForegroundStyleModifier: ChartModifier, Decodable {
    let value: AnyPlottableValue
    
    func body(content: Content) -> some ChartContent {
        func unbox(_ v: some Plottable) -> AnyChartContent {
            AnyChartContent(content.foregroundStyle(by: .value(value.label, v)))
        }
        return unbox(value.value)
    }
}
