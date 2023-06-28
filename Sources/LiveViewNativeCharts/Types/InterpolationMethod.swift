//
//  InterpolationMethod.swift
//
//
//  Created by Carson Katri on 6/28/23.
//

import Charts
import LiveViewNative

/// A method for interpolating lines.
///
/// Possible values:
/// * `cardinal`
/// * `catmull_rom`
/// * `linear`
/// * `monotone`
/// * `step_center`
/// * `step_end`
/// * `step_start`
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
extension InterpolationMethod: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        switch try container.decode(String.self) {
        case "cardinal": self = .cardinal
        case "catmull_rom": self = .catmullRom
        case "linear": self = .linear
        case "monotone": self = .monotone
        case "step_center": self = .stepCenter
        case "step_end": self = .stepEnd
        case "step_start": self = .stepStart
        case let `default`: throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath, debugDescription: "Unknown interpolation method `\(`default`)`"))
        }
    }
}
