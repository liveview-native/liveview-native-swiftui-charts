//
//  MarkDimension.swift
//
//
//  Created by Carson Katri on 6/13/23.
//

import Charts
import LiveViewNative
import LiveViewNativeCore

extension MarkDimension: AttributeDecodable {
    public init(from attribute: LiveViewNativeCore.Attribute?) throws {
        guard let value = attribute?.value
        else { throw AttributeDecodingError.missingAttribute(Self.self) }
        if value.hasPrefix("-") {
            guard let inset = Double(value.dropFirst())
            else { throw AttributeDecodingError.badValue(Self.self) }
            self = .inset(inset)
        } else if value.hasSuffix("%") {
            guard let ratio = Double(value.dropLast())
            else { throw AttributeDecodingError.badValue(Self.self) }
            self = .ratio(ratio / 100)
        } else if value == "automatic" {
            self = .automatic
        } else if let fixed = Double(value) {
            self = .fixed(fixed)
        } else {
            throw AttributeDecodingError.badValue(Self.self)
        }
    }
}
