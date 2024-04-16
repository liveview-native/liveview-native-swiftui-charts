//
//  PlottableValue.swift
//
//
//  Created by Carson Katri on 6/8/23.
//

import SwiftUI
import Charts
import Foundation
import LiveViewNative
import LiveViewNativeCore
import LiveViewNativeStylesheet

extension ElementNode {
    /// Decodes a `Plottable` value and label from an attribute.
    ///
    /// Supported types:
    /// * Date
    /// * Double
    /// * String
    func plottable(named: String) -> (label: String, value: any Plottable)? {
        guard let value = self.attributeValue(for: .init(namespace: named, name: "value")),
              let label = self.attributeValue(for: .init(namespace: named, name: "label"))
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
struct AnyPlottableValue: ParseableModifierValue {
    let label: Label
    let value: AttributeReference<AnyPlottable>
    
    enum Label {
        case constant(String)
        case text(TextReference)
    }
    
    static func parser(in context: ParseableModifierContext) -> some Parser<Substring.UTF8View, Self> {
        ImplicitStaticMember {
            ParseablePlottableValue.parser(in: context).map(\.value)
        }
    }
    
    @ParseableExpression
    struct ParseablePlottableValue {
        static var name: String { "value" }
        
        let value: AnyPlottableValue
        
        init(_ label: TextReference, _ value: AttributeReference<AnyPlottable>) {
            self.value = .init(label: .text(label), value: value)
        }
        
        init(_ label: String, _ value: AttributeReference<AnyPlottable>) {
            self.value = .init(label: .constant(label), value: value)
        }
    }
}

struct AnyPlottable: ParseableModifierValue, AttributeDecodable {
    let value: any Plottable
    
    static func parser(in context: ParseableModifierContext) -> some Parser<Substring.UTF8View, Self> {
        OneOf {
            Int.parser(in: context).map({ Self.init(value: $0) })
            Double.parser(in: context).map({ Self.init(value: $0) })
            Date.parser(in: context).map({ Self.init(value: $0) })
            String.parser(in: context).map({ Self.init(value: $0) })
        }
    }
    
    init(value: any Plottable) {
        self.value = value
    }
    
    init(from attribute: Attribute?, on element: ElementNode) throws {
        if let intValue = try? Int.init(from: attribute, on: element) {
            self.value = intValue
        } else if let doubleValue = try? Double.init(from: attribute, on: element) {
            self.value = doubleValue
        } else if let dateValue = try? Date.init(from: attribute, on: element) {
            self.value = dateValue
        } else if let stringValue = try? String.init(from: attribute, on: element) {
            self.value = stringValue
        } else {
            throw AttributeDecodingError.badValue(Self.self)
        }
    }
}
