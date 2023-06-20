//
//  ScaleType.swift
//
//
//  Created by Carson Katri on 6/20/23.
//

import Charts

/// A style of scale used with the ``ChartXScaleModifier`` and ``ChartYScaleModifier`` modifiers.
///
/// Possible values:
/// * `linear`
/// * `log`
/// * `date`
/// * `category`
/// * `square_root` (iOS 16.4+, macOS 13.3+, tvOS 16.4+, watchOS 9.4+)
/// * `symmetric_log`, `{:symmetric_log, slope_at_zero (number)}` (iOS 16.4+, macOS 13.3+, tvOS 16.4+, watchOS 9.4+)
/// * `{:power, exponent (number)}` (iOS 16.4+, macOS 13.3+, tvOS 16.4+, watchOS 9.4+)
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
extension ScaleType: Decodable {
    public init(from decoder: Decoder) throws {
        if var container = try? decoder.unkeyedContainer() {
            switch try container.decode(String.self) {
            case "power":
                if #available(iOS 16.4, macOS 13.3, tvOS 16.4, watchOS 9.4, *) {
                    self = .power(exponent: try container.decode(Double.self))
                } else {
                    throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath, debugDescription: "'power' is only available for iOS 16.4+"))
                }
            case "symmetric_log":
                if #available(iOS 16.4, macOS 13.3, tvOS 16.4, watchOS 9.4, *) {
                    self = .symmetricLog(slopeAtZero: try container.decode(Double.self))
                } else {
                    throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath, debugDescription: "'symmetric_log' is only available for iOS 16.4+"))
                }
            case let `default`:
                throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath, debugDescription: "Unknown scale type '\(`default`)'"))
            }
        } else {
            let container = try decoder.singleValueContainer()
            switch try container.decode(String.self) {
            case "linear": self = .linear
            case "log": self = .log
            case "date": self = .date
            case "category": self = .category
            case "square_root":
                if #available(iOS 16.4, macOS 13.3, tvOS 16.4, watchOS 9.4, *) {
                    self = .squareRoot
                } else {
                    throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath, debugDescription: "'square_root' is only available for iOS 16.4+"))
                }
            case "symmetric_log":
                if #available(iOS 16.4, macOS 13.3, tvOS 16.4, watchOS 9.4, *) {
                    self = .symmetricLog
                } else {
                    throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath, debugDescription: "'symmetric_log' is only available for iOS 16.4+"))
                }
            case let `default`:
                throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath, debugDescription: "Unknown scale type '\(`default`)'"))
            }
        }
    }
}
