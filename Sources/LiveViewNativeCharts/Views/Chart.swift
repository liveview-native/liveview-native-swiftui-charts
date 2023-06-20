//
//  Chart.swift
//
//
//  Created by Carson Katri on 6/8/23.
//

import SwiftUI
import LiveViewNative
import Charts

public struct Chart<R: RootRegistry>: View {
    @ObservedElement(observeChildren: true) private var element
    @ContentBuilderContext<R> private var context
    
    public var body: some View {
        Charts.Chart {
            AnyChartContent(try! ChartContentBuilder.buildChildren(of: element, in: context))
        }
    }
}
