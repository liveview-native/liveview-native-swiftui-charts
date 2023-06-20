//
//  BasicChartSymbolShape.swift
//
//
//  Created by Carson Katri on 6/19/23.
//

import Charts
import SwiftUI

/// A primitive chart symbol shape, used with the ``SymbolModifier`` modifier.
///
/// Possible values:
/// * `circle`
/// * `square`
/// * `triangle`
/// * `diamond`
/// * `pentagon`
/// * `plus`
/// * `cross`
/// * `asterisk`
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
extension BasicChartSymbolShape: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        switch try container.decode(String.self) {
        case "circle": self = .circle
        case "square": self = .square
        case "triangle": self = .triangle
        case "diamond": self = .diamond
        case "pentagon": self = .pentagon
        case "plus": self = .plus
        case "cross": self = .cross
        case "asterisk": self = .asterisk
        case let `default`:
            throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath, debugDescription: "Unknown shape `\(`default`)`"))
        }
    }
}
