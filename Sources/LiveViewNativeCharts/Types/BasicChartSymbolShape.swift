//
//  BasicChartSymbolShape.swift
//
//
//  Created by Carson Katri on 6/19/23.
//

import Charts
import SwiftUI

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
