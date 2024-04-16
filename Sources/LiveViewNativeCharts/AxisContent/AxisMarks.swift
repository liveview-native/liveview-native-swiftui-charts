//
//  AxisMarks.swift
//
//
//  Created by Carson Katri on 6/14/23.
//

import Charts
import LiveViewNative
import LiveViewNativeCore
import SwiftUI

/// An element used as the content for the ``ChartXAxisModifier`` and ``ChartYAxisModifier``.
///
/// Use this element to configure how the X/Y axes of the chart are displayed.
///
/// ### Axis Format
/// Use the `format` attribute to customize the axis display.
///
/// ```html
/// <AxisMarks format="byte-count" style="file" spells-out-zero />
/// ```
///
/// Possible formats:
/// - Note: Additional attributes are displayed underneath the format.
/// * `date-time`
/// * `iso8601`
/// * `number`
/// * `percent`
/// * `currency`
///   * `currency-code` - The identifier of the currency to display, such as `usd`
/// * `byte-count`
///   * `style` - The ``LiveViewNativeCharts/Foundation/ByteCountFormatStyle/Style`` to use
///   * `allowed-units` - The ``LiveViewNativeCharts/Foundation/ByteCountFormatStyle/Units`` to use
///   * `spells-out-zero` - Whether `0` is written as `zero`
///   * `includes-actual-byte-count` - Whether the number of bytes is included after the formatted string
///
/// ### Axis Content
/// Provide custom content within the `AxisMarks` element to enable certain marks with further customization.
///
/// ```html
/// <AxisMarks>
///   <AxisGridLine class="fg-red" />
/// </AxisMarks>
/// ```
///
/// Use a loop with ``AxisValue`` elements to create custom marks.
///
/// ```html
/// <AxisMarks>
///   <%= for item <- 1..10 do %>
///     <AxisValue value={item}>
///       <AxisValueLabel>Value: <%= item %></AxisValueLabel>
///       <AxisTick />
///     </AxisValue>
///   <% end %>
/// </AxisMarks>
/// ```
///
/// ## Attributes
/// * `preset` - The ``LiveViewNativeCharts/Charts/AxisMarkPreset`` to use.
/// * `position` - The ``LiveViewNativeCharts/Charts/AxisMarkPosition`` to use.
/// * `values` - The ``LiveViewNativeCharts/Charts/AxisMarkValues`` to use.
/// * `stroke` - The ``LiveViewNativeCharts/SwiftUI/StrokeStyle`` to use.
/// * `format` - The format style for the axis marks.
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
struct AxisMarks<R: RootRegistry>: ComposedAxisContent {
    let element: ElementNode
    let context: AxisContentBuilder.Context<R>
    
    var body: some AxisContent {
        let preset = (try? element.attributeValue(AxisMarkPreset.self, for: "preset")) ?? .automatic
        let position = (try? element.attributeValue(AxisMarkPosition.self, for: "position")) ?? .automatic
        let values = AxisMarkValues(from: element) ?? .automatic
        let stroke = try? element.attributeValue(StrokeStyle.self, for: "stroke")
        
        if let format = element.attributeValue(for: "format") {
            switch format {
            case "date-time", "date_time":
                Charts.AxisMarks(
                    format: .dateTime,
                    preset: preset,
                    position: position,
                    values: values,
                    stroke: stroke
                )
            case "iso8601":
                Charts.AxisMarks(
                    format: .iso8601,
                    preset: preset,
                    position: position,
                    values: values,
                    stroke: stroke
                )
            case "number":
                Charts.AxisMarks(
                    format: FloatingPointFormatStyle<Double>.number,
                    preset: preset,
                    position: position,
                    values: values,
                    stroke: stroke
                )
            case "percent":
                Charts.AxisMarks(
                    format: FloatingPointFormatStyle<Double>.Percent.percent,
                    preset: preset,
                    position: position,
                    values: values,
                    stroke: stroke
                )
            case "currency":
                Charts.AxisMarks(
                    format: .currency(code: element.attributeValue(for: "currency-code")!),
                    preset: preset,
                    position: position,
                    values: values,
                    stroke: stroke
                )
            case "byte-count", "byte_count":
                Charts.AxisMarks(
                    format: .byteCount(
                        style: (try? element.attributeValue(ByteCountFormatStyle.Style.self, for: "style")) ?? .binary,
                        allowedUnits: (try? element.attributeValue(ByteCountFormatStyle.Units.self, for: "allowed-units")) ?? .default,
                        spellsOutZero: element.attributeBoolean(for: "spells-out-zero"),
                        includesActualByteCount: element.attributeBoolean(for: "includes-actual-byte-count")
                    ),
                    preset: preset,
                    position: position,
                    values: values,
                    stroke: stroke
                )
            default:
                fatalError("Unknown format '\(format)'")
            }
        } else if element.elementChildren().allSatisfy({ $0.tag == "AxisValue" }) {
            let children = element.children()
            let values = children
                .compactMap {
                    try? $0.attributes
                        .first(where: { $0.name == "value" })
                        .map(Double.init)
                }
            Charts.AxisMarks(preset: preset, position: position, values: values) { (value: Charts.AxisValue) in
                AnyAxisMark(
                    try! AxisContentBuilder.build(
                        children.filter({
                            (try? $0.attributes
                                .first(where: { $0.name == "value" })
                                .map(Double.init))
                            == value.as(Double.self)
                        }),
                        with: AxisMarkBuilder.self,
                        in: context
                    )
                )
            }
        } else if !element.children().isEmpty {
            Charts.AxisMarks(preset: preset, position: position, values: values) {
                AnyAxisMark(
                    try! AxisContentBuilder.buildChildren(
                        of: element,
                        with: AxisMarkBuilder.self,
                        in: context
                    )
                )
            }
        } else {
            Charts.AxisMarks(
                preset: preset,
                position: position,
                values: values,
                stroke: stroke
            )
        }
    }
}

/// A style for byte count formatting.
///
/// Possible values:
/// * `file`
/// * `memory`
/// * `decimal`
/// * `binary`
extension ByteCountFormatStyle.Style: AttributeDecodable {
    public init(from attribute: LiveViewNativeCore.Attribute?) throws {
        guard let value = attribute?.value
        else { throw AttributeDecodingError.missingAttribute(Self.self) }
        switch value {
        case "file": self = .file
        case "memory": self = .memory
        case "decimal": self = .decimal
        case "binary": self = .binary
        default: throw AttributeDecodingError.badValue(Self.self)
        }
    }
}

/// The units allowed to be displayed.
///
/// Possible values:
/// * `bytes`
/// * `kb`
/// * `mb`
/// * `gb`
/// * `tb`
/// * `pb`
/// * `eb`
/// * `zb`
/// * `ybOrHigher`
/// * `all`
/// * `default`
/// * A comma-separated list of these values
extension ByteCountFormatStyle.Units: AttributeDecodable {
    public init(from attribute: LiveViewNativeCore.Attribute?) throws {
        guard let value = attribute?.value
        else { throw AttributeDecodingError.missingAttribute(Self.self) }
        self.init([])
        for unit in value.split(separator: ",") {
            switch unit.trimmingCharacters(in: .whitespaces) {
            case "bytes": self.insert(.bytes)
            case "kb": self.insert(.kb)
            case "mb": self.insert(.mb)
            case "gb": self.insert(.gb)
            case "tb": self.insert(.tb)
            case "pb": self.insert(.pb)
            case "eb": self.insert(.eb)
            case "zb": self.insert(.zb)
            case "ybOrHigher": self.insert(.ybOrHigher)
            case "all": self.insert(.all)
            case "default": self.insert(.`default`)
            default: throw AttributeDecodingError.badValue(Self.self)
            }
        }
    }
}

/// A preset to use for axis marks.
///
/// Possible values:
/// * automatic
/// * extended
/// * aligned
/// * inset
extension AxisMarkPreset: AttributeDecodable {
    public init(from attribute: LiveViewNativeCore.Attribute?) throws {
        guard let value = attribute?.value
        else { throw AttributeDecodingError.missingAttribute(Self.self) }
        switch value {
        case "automatic": self = .automatic
        case "extended": self = .extended
        case "aligned": self = .aligned
        case "inset": self = .inset
        default: throw AttributeDecodingError.badValue(Self.self)
        }
    }
}

extension AxisMarkPosition: AttributeDecodable {
    public init(from attribute: LiveViewNativeCore.Attribute?) throws {
        guard let value = attribute?.value
        else { throw AttributeDecodingError.missingAttribute(Self.self) }
        switch value {
        case "automatic": self = .automatic
        case "leading": self = .leading
        case "trailing": self = .trailing
        case "top": self = .top
        case "bottom": self = .bottom
        default: throw AttributeDecodingError.badValue(Self.self)
        }
    }
}

/// The values to use as the axis marks.
///
/// Possible values:
/// * `automatic`
///   * Additional Attributes
///     * `minimum-stride` (number)
///     * `desired-count` (integer)
///     * `round-lower-bound` (boolean)
///     * `round-upper-bound` (boolean)
/// * `stride`
///   * Additional Attributes
///     * `stride` (number or ``LiveViewNativeCharts/Foundation/Calendar/Component``, required)
///     * `count` (integer)
///     * `round-lower-bound` (boolean)
///     * `round-upper-bound` (boolean)
///     * `calendar` (``LiveViewNativeCharts/Foundation/Calendar/Identifier``)
extension AxisMarkValues {
    public init?(from element: ElementNode) {
        if let values = element.attributeValue(for: "values") {
            switch values {
            case "automatic":
                if let minimumStride = try? element.attributeValue(Double.self, for: "minimum-stride") {
                    self = .automatic(
                        minimumStride: minimumStride,
                        desiredCount: try? element.attributeValue(Int.self, for: "desired-count"),
                        roundLowerBound: element.attributeBoolean(for: "round-lower-bound"),
                        roundUpperBound: element.attributeBoolean(for: "round-upper-bound")
                    )
                } else {
                    self = .automatic(
                        desiredCount: try? element.attributeValue(Int.self, for: "desired-count"),
                        roundLowerBound: element.attributeBoolean(for: "round-lower-bound"),
                        roundUpperBound: element.attributeBoolean(for: "round-upper-bound")
                    )
                }
            case "stride":
                if let numeric = try? element.attributeValue(Double.self, for: "stride") {
                    self = .stride(
                        by: numeric,
                        roundLowerBound: element.attributeBoolean(for: "round-lower-bound"),
                        roundUpperBound: element.attributeBoolean(for: "round-upper-bound")
                    )
                } else if let component = try? element.attributeValue(Calendar.Component.self, for: "stride") {
                    self = .stride(
                        by: component,
                        count: (try? element.attributeValue(Int.self, for: "count")) ?? 1,
                        roundLowerBound: element.attributeBoolean(for: "round-lower-bound"),
                        roundUpperBound: element.attributeBoolean(for: "round-upper-bound"),
                        calendar: (try? element.attributeValue(Calendar.Identifier.self, for: "calendar")).flatMap(Calendar.init(identifier:))
                    )
                }
            default:
                return nil
            }
        }
        return nil
    }
}

/// A component of a date.
///
/// Possible values:
/// * `era`
/// * `year`
/// * `month`
/// * `day`
/// * `hour`
/// * `minute`
/// * `second`
/// * `weekday`
/// * `weekday_ordinal`
/// * `quarter`
/// * `week_of_month`
/// * `week_of_year`
/// * `year_for_week_of_year`
/// * `nanosecond`
/// * `calendar`
/// * `time_zone`
/// * `is_leap_month`
extension Calendar.Component: AttributeDecodable {
    public init(from attribute: LiveViewNativeCore.Attribute?) throws {
        guard let value = attribute?.value
        else { throw AttributeDecodingError.missingAttribute(Self.self) }
        switch value {
        case "era": self = .era
        case "year": self = .year
        case "month": self = .month
        case "day": self = .day
        case "hour": self = .hour
        case "minute": self = .minute
        case "second": self = .second
        case "weekday": self = .weekday
        case "weekday_ordinal": self = .weekdayOrdinal
        case "quarter": self = .quarter
        case "week_of_month": self = .weekOfMonth
        case "week_of_year": self = .weekOfYear
        case "year_for_week_of_year": self = .yearForWeekOfYear
        case "nanosecond": self = .nanosecond
        case "calendar": self = .calendar
        case "time_zone": self = .timeZone
        case "is_leap_month":
            if #available(macOS 14, iOS 17, tvOS 17, watchOS 10, *) {
                self = .isLeapMonth
            } else {
                throw AttributeDecodingError.badValue(Self.self)
            }
        default: throw AttributeDecodingError.badValue(Self.self)
        }
    }
}

/// A type of calendar.
///
/// Possible values:
/// * `gregorian`
/// * `buddhist`
/// * `chinese`
/// * `coptic`
/// * `ethiopic_amete_mihret`
/// * `ethiopic_amete_alem`
/// * `hebrew`
/// * `iso8601`
/// * `indian`
/// * `islamic`
/// * `islamic_civil`
/// * `japanese`
/// * `persian`
/// * `republic_of_china`
/// * `islamic_tabular`
/// * `islamic_umm_al_qura`
extension Calendar.Identifier: AttributeDecodable {
    public init(from attribute: LiveViewNativeCore.Attribute?) throws {
        guard let value = attribute?.value
        else { throw AttributeDecodingError.missingAttribute(Self.self) }
        switch value {
        case "gregorian": self = .gregorian
        case "buddhist": self = .buddhist
        case "chinese": self = .chinese
        case "coptic": self = .coptic
        case "ethiopic_amete_mihret": self = .ethiopicAmeteMihret
        case "ethiopic_amete_alem": self = .ethiopicAmeteAlem
        case "hebrew": self = .hebrew
        case "iso8601": self = .iso8601
        case "indian": self = .indian
        case "islamic": self = .islamic
        case "islamic_civil": self = .islamicCivil
        case "japanese": self = .japanese
        case "persian": self = .persian
        case "republic_of_china": self = .republicOfChina
        case "islamic_tabular": self = .islamicTabular
        case "islamic_umm_al_qura": self = .islamicUmmAlQura
        default: throw AttributeDecodingError.badValue(Self.self)
        }
    }
}

extension StrokeStyle: AttributeDecodable {
    public init(from attribute: LiveViewNativeCore.Attribute?) throws {
        self = .init(lineWidth: try Double(from: attribute))
    }
}
