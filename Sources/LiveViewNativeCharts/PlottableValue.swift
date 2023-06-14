//
//  PlottableValue.swift
//
//
//  Created by Carson Katri on 6/8/23.
//

import Charts
import Foundation
import LiveViewNative
import LiveViewNativeCore

extension ElementNode {
    /// Decodes a `Plottable` value and label from an attribute.
    ///
    /// Supported types:
    /// * Date
    /// * Double
    /// * String
    func plottable(named: AttributeName) -> (label: String, value: any Plottable)? {
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

/// A value that can be displayed on a chart.
///
/// Plottable values can be created with a tuple, where the first element is the label and the second element is the value.
///
/// ```elixir
/// {"Date", item.date}
/// {"Count", item.number}
/// ```
///
/// ### Supported Types
/// The following types can be plot:
/// * number
/// * string
/// * DateTime
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
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
