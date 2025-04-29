//
//  BasicChartSymbolShape.swift
//
//
//  Created by Carson Katri on 6/19/23.
//

import Charts
import SwiftUI
import LiveViewNative
import LiveViewNativeStylesheet

extension BasicChartSymbolShape {
    enum Resolvable: Decodable, StylesheetResolvable {
        case circle
        case square
        case triangle
        case diamond
        case pentagon
        case plus
        case cross
        case asterisk
        
        func resolve<R>(on element: ElementNode, in context: LiveContext<R>) -> BasicChartSymbolShape where R : RootRegistry {
            switch self {
            case .circle:
                return .circle
            case .square:
                return .square
            case .triangle:
                return .triangle
            case .diamond:
                return .diamond
            case .pentagon:
                return .pentagon
            case .plus:
                return .plus
            case .cross:
                return .cross
            case .asterisk:
                return .asterisk
            }
        }
    }
}
