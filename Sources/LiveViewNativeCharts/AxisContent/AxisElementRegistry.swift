//
//  AxisElementRegistry.swift
//
//
//  Created by Carson Katri on 6/14/23.
//

import Charts
@_spi(LiveViewNative) import LiveViewNative

enum AxisElementRegistry<R: RootRegistry> {
    @AxisContentBuilder
    static func lookupAxisContent(_ node: ElementNode, context: LiveContextStorage<R>) -> some AxisContent {
        switch node.tag {
        case "AxisMarks":
            AxisMarks(element: node, context: context).body
        default:
            fatalError(ChartError.unknownTag(node.tag).localizedDescription)
        }
    }
    
    @AxisMarkBuilder
    static func lookupAxisMark(_ node: ElementNode, context: LiveContextStorage<R>) -> some AxisMark {
        switch node.tag {
        case "AxisGridLine":
            AxisGridLine(element: node).body
        default:
            fatalError(ChartError.unknownTag(node.tag).localizedDescription)
        }
    }
}

enum AxisMarkModifierType: String, Codable {
    case font
    case foregroundStyle = "foreground_style"
    case offset
}

enum AxisMarkModifierRegistry<R: RootRegistry>: AxisMarkModifierRegistryProtocol {
    @AxisMarkModifierBuilder
    static func decodeModifier(_ type: AxisMarkModifierType, from decoder: Decoder) throws -> some AxisMarkModifier {
        switch type {
        case .font:
            try FontModifier(from: decoder)
        case .offset:
            try OffsetModifier(from: decoder)
        case .foregroundStyle:
            try ForegroundStyleModifier(from: decoder)
        }
    }
}

protocol AxisMarkModifierRegistryProtocol {
    associatedtype BuiltinModifier: AxisMarkModifier
    static func decodeModifier(_ type: AxisMarkModifierType, from decoder: Decoder) throws -> BuiltinModifier
}
