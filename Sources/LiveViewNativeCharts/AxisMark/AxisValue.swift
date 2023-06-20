//
//  AxisValue.swift
//
//
//  Created by Carson Katri on 6/15/23.
//

import Charts
import LiveViewNative

/// A value in an ``AxisMarks`` element.
///
/// Use this element within an ``AxisMarks`` element to create custom marks.
///
/// - Note: Only numeric values are supported.
///
/// ```html
/// <AxisMarks>
///   <%= for item <- 1..10 do %>
///     <AxisValue value={item}>
///       <AxisValueLabel>Value: <%= item %></AxisValueLabel>
///     </AxisValue>
///   <% end %>
/// </AxisMarks>
/// ```
///
/// ## Attributes
/// * `value`
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
struct AxisValue<R: RootRegistry>: ComposedAxisMark {
    let element: ElementNode
    let context: AxisMarkBuilder.Context<R>
    
    var body: some AxisMark {
        AnyAxisMark(
            try! AxisMarkBuilder.buildChildren(of: element, in: context)
        )
    }
}
