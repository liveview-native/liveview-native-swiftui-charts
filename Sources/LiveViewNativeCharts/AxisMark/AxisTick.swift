//
//  AxisTick.swift
//
//
//  Created by Carson Katri on 6/14/23.
//

import Charts
import SwiftUI
import LiveViewNative
import LiveViewNativeCore

/// An axis mark that adds ticks.
///
/// Use this element in the content of an ``AxisMarks`` element to display grid lines in your chart.
///
/// ```html
/// <AxisMarks>
///   <AxisTick
///     centered
///     length="longest-label"
///     modifiers={foreground_style(@native, primary: {:color, :red})}
///   />
/// </AxisMarks>
/// ```
///
/// ## Attributes
/// * `centered` - Centers the ticks between two axis values.
/// * `length` - The length of the ticks.
/// * `stroke` - The ``LiveViewNativeCharts/SwiftUI/StrokeStyle`` to use.
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
struct AxisTick: ComposedAxisMark {
    let element: ElementNode
    
    var body: some AxisMark {
        Charts.AxisTick(
            centered: element.attributeBoolean(for: "centered"),
            length: (try? element.attributeValue(Charts.AxisTick.Length.self, for: "length")) ?? .automatic,
            stroke: try? element.attributeValue(StrokeStyle.self, for: "stroke")
        )
    }
}

/// The length of a tick.
///
/// Possible values:
/// * `automatic`
/// * `label`
/// * `longest-label`
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
extension Charts.AxisTick.Length: AttributeDecodable {
    public init(from attribute: LiveViewNativeCore.Attribute?) throws {
        guard let value = attribute?.value
        else { throw AttributeDecodingError.missingAttribute(Self.self) }
        switch value {
        case "automatic": self = .automatic
        case "label": self = .label
        case "longest-label", "longest_label": self = .longestLabel
        default:
            throw AttributeDecodingError.badValue(Self.self)
        }
    }
}
