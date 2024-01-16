//
//  BasicChartSymbolShape.swift
//
//
//  Created by Carson Katri on 6/19/23.
//

import Charts
import SwiftUI
import LiveViewNativeStylesheet

extension BasicChartSymbolShape: ParseableModifierValue {
    public static func parser(in context: ParseableModifierContext) -> some Parser<Substring.UTF8View, Self> {
        ImplicitStaticMember([
            "circle": .circle,
            "square": .square,
            "triangle": .triangle,
            "diamond": .diamond,
            "pentagon": .pentagon,
            "plus": .plus,
            "cross": .cross,
            "asterisk": .asterisk,
        ])
    }
}
