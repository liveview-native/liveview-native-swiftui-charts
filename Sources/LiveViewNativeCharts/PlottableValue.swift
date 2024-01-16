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
struct AnyPlottableValue: ParseableModifierValue {
    let label: Label
    let value: AnyPlottable
    
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
        
        init(_ label: TextReference, _ value: AnyPlottable) {
            self.value = .init(label: .text(label), value: value)
        }
        
        init(_ label: String, _ value: AnyPlottable) {
            self.value = .init(label: .constant(label), value: value)
        }
    }
}

struct AnyPlottable: ParseableModifierValue {
    private let _resolve: (ElementNode) -> any Plottable
    
    static func parser(in context: ParseableModifierContext) -> some Parser<Substring.UTF8View, Self> {
        OneOf {
            AttributeReference<Int>.parser(in: context).map({ Self.init(_resolve: $0.resolve) })
            AttributeReference<Double>.parser(in: context).map({ Self.init(_resolve: $0.resolve) })
            AttributeReference<Date>.parser(in: context).map({ Self.init(_resolve: $0.resolve) })
            AttributeReference<String>.parser(in: context).map({ Self.init(_resolve: $0.resolve) })
        }
    }
    
    func resolve(on element: ElementNode) -> any Plottable {
        _resolve(element)
    }
}
