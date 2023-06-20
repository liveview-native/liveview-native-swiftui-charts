//
//  ChartXAxisModifier.swift
//
//
//  Created by Carson Katri on 6/14/23.
//

import Charts
import SwiftUI
import LiveViewNative

/// Configure the visibility/content of the X axis.
///
/// Provide a ``visibility`` to configure if the axis is shown/hidden.
///
/// ```html
/// <Chart
///   modifiers={chart_x_axis(@native, visibility: :hidden)}
/// >
///   ...
/// </Chart>
/// ```
///
/// Use the ``content`` argument to provide custom ``AxisMarks``.
///
/// ```html
/// <Chart
///   modifiers={chart_x_axis(@native, content: :my_axes)}
/// >
///   ...
///   <AxisMarks template={:my_axes}>
///     ...
///   </AxisMarks>
/// </Chart>
/// ```
///
/// ## Arguments
/// * ``visibility``
/// * ``content``
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
struct ChartXAxisModifier<R: RootRegistry>: ViewModifier, Decodable {
    /// The visibility of the axis.
    ///
    /// Possible values:
    /// * `automatic`
    /// * `visible`
    /// * `hidden`
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private let visibility: Visibility?
    
    /// A reference to the `AxisMarks` element to use.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private let content: String?
    
    @ObservedElement(observeChildren: true) private var element
    @ContentBuilderContext<R> private var context
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.visibility = try container.decodeIfPresent(Visibility.self, forKey: .visibility)
        self.content = try container.decodeIfPresent(String.self, forKey: .content)
    }
    
    func body(content: Content) -> some View {
        if let visibility {
            content.chartXAxis(visibility)
        } else if let template = self.content {
            content.chartXAxis {
                AnyAxisContent(
                    try! AxisContentBuilder.buildChildren(
                        of: element,
                        forTemplate: template,
                        in: context
                    )
                )
            }
        } else {
            content
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case visibility
        case content
    }
}
