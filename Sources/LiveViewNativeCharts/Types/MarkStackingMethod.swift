//
//  MarkStackingMethod.swift
//
//
//  Created by Carson Katri on 6/13/23.
//

import Charts
import LiveViewNative
import LiveViewNativeCore

extension MarkStackingMethod: AttributeDecodable {
    public init(from attribute: LiveViewNativeCore.Attribute?) throws {
        guard let value = attribute?.value
        else { throw AttributeDecodingError.missingAttribute(Self.self) }
        switch value {
        case "standard": self = .standard
        case "normalized": self = .normalized
        case "center": self = .center
        case "unstacked": self = .unstacked
        default: throw AttributeDecodingError.badValue(Self.self)
        }
    }
}
