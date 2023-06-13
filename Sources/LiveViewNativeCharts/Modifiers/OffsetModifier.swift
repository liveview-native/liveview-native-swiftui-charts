//
//  OffsetModifier.swift
//
//
//  Created by Carson Katri on 6/8/23.
//

import Charts
import LiveViewNative

// this modifier is created by `liveview-client-swiftui`, and an implementation for Charts is provided here.
struct OffsetModifier: ChartModifier, Decodable {
    let x: Double?
    let y: Double?
    
    func body(content: Content) -> some ChartContent {
        content.offset(x: x ?? 0, y: y ?? 0)
    }
}
