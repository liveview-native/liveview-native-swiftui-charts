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
extension MarkDimension: AttributeDecodable, Decodable {
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
    
    /// A size to use for a mark.
    ///
    /// `:automatic` is the simplest way to create a mark dimension.
    ///
    /// In other cases, use a tuple where the first element is the type, and the second is the value.
    ///
    /// `fixed`, `inset`, and `ratio` types can be used.
    ///
    /// ```elixir
    /// {:fixed, 50}
    /// {:inset, 15}
    /// {:ratio, 0.5}
    /// ```
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let value = try container.decode(Double.self, forKey: .value)
        switch try container.decode(MarkDimensionType.self, forKey: .type) {
        case .automatic:
            self = .automatic
        case .fixed:
            self = .fixed(value)
        case .inset:
            self = .inset(value)
        case .ratio:
            self = .ratio(value)
        }
    }
    
    enum MarkDimensionType: String, Decodable {
        case automatic
        case ratio
        case inset
        case fixed
    }
    
    enum CodingKeys: CodingKey {
        case type
        case value
    }
}
