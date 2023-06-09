//
//  MarkDimension.swift
//
//
//  Created by Carson Katri on 6/13/23.
//

import Charts
import LiveViewNative
import LiveViewNativeCore

/// A size to use for a mark.
///
/// Possible values:
/// * `automatic`
/// * A fixed number: `75`
/// * A ratio with the `%` suffix: `50%`
/// * An inset with the `-` prefix: `-10`
extension MarkDimension: AttributeDecodable {
    public init(from attribute: LiveViewNativeCore.Attribute?) throws {
        guard let value = attribute?.value
        else { throw AttributeDecodingError.missingAttribute(Self.self) }
        if value.hasSuffix("%") {
            guard let ratio = Double(value.dropLast())
            else { throw AttributeDecodingError.badValue(Self.self) }
            self = .ratio(ratio / 100)
        } else if value.hasPrefix("-") {
            guard let inset = Double(value.dropFirst())
            else { throw AttributeDecodingError.badValue(Self.self) }
            self = .inset(inset)
        } else if value == "automatic" {
            self = .automatic
        } else if let fixed = Double(value) {
            self = .fixed(fixed)
        } else {
            throw AttributeDecodingError.badValue(Self.self)
        }
    }
}
