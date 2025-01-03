//
//  AxisValueLabel.swift
//
//
//  Created by Carson Katri on 6/15/23.
//

import Charts
import SwiftUI
import LiveViewNative
import LiveViewNativeCore

/// An axis mark that adds labels.
///
/// Use this element in the content of an ``AxisMarks`` element to display labels in your chart.
///
/// ```html
/// <AxisMarks>
///   <AxisValueLabel
///     format="date-time"
///   />
/// </AxisMarks>
/// ```
///
/// Custom views or text can also be displayed. This is especially useful when using ``AxisValue`` elements.
///
/// ```html
/// <AxisValueLabel>
///   <Image system-name="arrow.up" />
/// </AxisValueLabel>
/// ```
///
/// ## Attributes
/// * `centered` - Centers the ticks between two axis values.
/// * `length` - The length of the ticks.
/// * `stroke` - The ``LiveViewNativeCharts/SwiftUI/StrokeStyle`` to use.
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
@MainActor
struct AxisValueLabel<R: RootRegistry>: ComposedAxisMark {
    let element: ElementNode
    let context: AxisMarkBuilder.Context<R>
    
    var body: some AxisMark {
        let centered = element.attributeBoolean(for: "centered")
        let anchor = try? element.attributeValue(UnitPoint.self, for: "anchor")
        let multiLabelAlignment = try? element.attributeValue(Alignment.self, for: "multi-label-alignment")
        let collisionResolution = (try? element.attributeValue(AxisValueLabelCollisionResolution.self, for: "collision-resolution")) ?? .automatic
        let offsetsMarks = element.attributeBoolean(for: "offsets-marks")
        let orientation = (try? element.attributeValue(AxisValueLabelOrientation.self, for: "orientation")) ?? .automatic
        let horizontalSpacing = (try? element.attributeValue(Double.self, for: "horizontal-spacing"))
            .flatMap(CGFloat.init)
        let verticalSpacing = (try? element.attributeValue(Double.self, for: "vertical-spacing"))
            .flatMap(CGFloat.init)
        
        if let format = element.attributeValue(for: "format") {
            switch format {
            case "date-time", "date_time":
                Charts.AxisValueLabel(
                    format: .dateTime,
                    centered: centered,
                    anchor: anchor,
                    multiLabelAlignment: multiLabelAlignment,
                    collisionResolution: collisionResolution,
                    offsetsMarks: offsetsMarks,
                    orientation: orientation,
                    horizontalSpacing: horizontalSpacing,
                    verticalSpacing: verticalSpacing
                )
            case "iso8601":
                Charts.AxisValueLabel(
                    format: .iso8601,
                    centered: centered,
                    anchor: anchor,
                    multiLabelAlignment: multiLabelAlignment,
                    collisionResolution: collisionResolution,
                    offsetsMarks: offsetsMarks,
                    orientation: orientation,
                    horizontalSpacing: horizontalSpacing,
                    verticalSpacing: verticalSpacing
                )
            case "number":
                Charts.AxisValueLabel(
                    format: FloatingPointFormatStyle<Double>.number,
                    centered: centered,
                    anchor: anchor,
                    multiLabelAlignment: multiLabelAlignment,
                    collisionResolution: collisionResolution,
                    offsetsMarks: offsetsMarks,
                    orientation: orientation,
                    horizontalSpacing: horizontalSpacing,
                    verticalSpacing: verticalSpacing
                )
            case "percent":
                Charts.AxisValueLabel(
                    format: FloatingPointFormatStyle<Double>.Percent.percent,
                    centered: centered,
                    anchor: anchor,
                    multiLabelAlignment: multiLabelAlignment,
                    collisionResolution: collisionResolution,
                    offsetsMarks: offsetsMarks,
                    orientation: orientation,
                    horizontalSpacing: horizontalSpacing,
                    verticalSpacing: verticalSpacing
                )
            case "currency":
                Charts.AxisValueLabel(
                    format: .currency(code: element.attributeValue(for: "currency-code") ?? "usd"),
                    centered: centered,
                    anchor: anchor,
                    multiLabelAlignment: multiLabelAlignment,
                    collisionResolution: collisionResolution,
                    offsetsMarks: offsetsMarks,
                    orientation: orientation,
                    horizontalSpacing: horizontalSpacing,
                    verticalSpacing: verticalSpacing
                )
            case "byte-count", "byte_count":
                Charts.AxisValueLabel(
                    format: .byteCount(
                        style: (try? element.attributeValue(ByteCountFormatStyle.Style.self, for: "style")) ?? .binary,
                        allowedUnits: (try? element.attributeValue(ByteCountFormatStyle.Units.self, for: "allowed-units")) ?? .default,
                        spellsOutZero: element.attributeBoolean(for: "spells-out-zero"),
                        includesActualByteCount: element.attributeBoolean(for: "includes-actual-byte-count")
                    ),
                    centered: centered,
                    anchor: anchor,
                    multiLabelAlignment: multiLabelAlignment,
                    collisionResolution: collisionResolution,
                    offsetsMarks: offsetsMarks,
                    orientation: orientation,
                    horizontalSpacing: horizontalSpacing,
                    verticalSpacing: verticalSpacing
                )
            default:
                fatalError("Unknown format '\(format)'")
            }
        } else {
            let childViews = AxisMarkBuilder.buildChildViews(
                of: element,
                in: context
            )
            Charts.AxisValueLabel(
                centered: centered,
                anchor: anchor,
                multiLabelAlignment: multiLabelAlignment,
                collisionResolution: collisionResolution,
                offsetsMarks: offsetsMarks,
                orientation: orientation,
                horizontalSpacing: horizontalSpacing,
                verticalSpacing: verticalSpacing
            ) {
                childViews
            }
        }
    }
}

extension AxisValueLabelCollisionResolution: AttributeDecodable {
    public init(from attribute: LiveViewNativeCore.Attribute?) throws {
        guard let value = attribute?.value
        else { throw AttributeDecodingError.missingAttribute(Self.self) }
        switch value {
        case "automatic": self = .automatic
        case "greedy": self = .greedy
        case "truncate": self = .truncate
        case "disabled": self = .disabled
        default:
            throw AttributeDecodingError.badValue(Self.self)
        }
    }
}

extension AxisValueLabelOrientation: AttributeDecodable {
    public init(from attribute: LiveViewNativeCore.Attribute?) throws {
        guard let value = attribute?.value
        else { throw AttributeDecodingError.missingAttribute(Self.self) }
        switch value {
        case "automatic": self = .automatic
        case "horizontal": self = .horizontal
        case "vertical": self = .vertical
        case "vertical-reversed", "vertical_reversed": self = .verticalReversed
        default:
            throw AttributeDecodingError.badValue(Self.self)
        }
    }
}
