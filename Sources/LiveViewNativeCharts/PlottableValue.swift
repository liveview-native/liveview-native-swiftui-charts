//
//  PlottableValue.swift
//
//
//  Created by Carson Katri on 6/8/23.
//

import Charts
import Foundation
@_spi(LiveViewNative) import LiveViewNative
import LiveViewNativeCore

extension ElementNode {
    /// Decodes a `Plottable` value and label from an attribute.
    ///
    /// Supported types:
    /// * Date
    /// * Double
    /// * String
    func plottable(named: AttributeName) -> (String, any Plottable)? {
        guard let value = self.attributeValue(for: named),
              let label = self.attributeValue(for: .init(namespace: named.rawValue, name: "label"))
        else { return nil }
        if let date = try? Date(value, strategy: .elixirDateTimeOrDate) {
            return (label, date)
        } else if let number = Double(value) {
            return (label, number)
        } else {
            return (label, value)
        }
    }
}

/// A decodable `PlottableValue` argument on a ``ChartModifier``.
struct AnyPlottableValue: Decodable {
    let label: String
    let value: any Plottable
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.label = try container.decode(String.self, forKey: .label)
        
        if let value = try? container.decode(Date.self, forKey: .value) {
            self.value = value
        } else if let value = try? container.decode(Double.self, forKey: .value) {
            self.value = value
        } else {
            self.value = try container.decode(String.self, forKey: .value)
        }
    }
    
    enum CodingKeys: CodingKey {
        case label
        case value
    }
}
