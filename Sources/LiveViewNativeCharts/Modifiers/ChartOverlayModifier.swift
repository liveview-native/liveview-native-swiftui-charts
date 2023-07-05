//
//  ChartOverlayModifier.swift
//
//
//  Created by Carson Katri on 7/5/23.
//

import Charts
import SwiftUI
import LiveViewNative

/// Add an overlay to a chart.
///
/// Provide a reference to a template element with the ``content`` argument.
///
/// ```html
/// <Chart
///   modifiers={chart_overlay(alignment: :leading, content: :my_overlay)}
/// >
///   ...
///   <Text template={:my_overlay}>Hello, world!</Text>
/// </Chart>
/// ```
///
/// ## Arguments
/// * ``alignment``
/// * ``content``
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
struct ChartOverlayModifier<R: RootRegistry>: ViewModifier, Decodable {
    /// The alignment of content within the overlay.
    ///
    /// See ``LiveViewNativeCharts/LiveViewNative/SwiftUI/Alignment`` for a list of possible values.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private let alignment: Alignment
    
    /// A reference to the Views to use in the overlay.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private let content: String
    
    @ObservedElement private var element
    @LiveContext<R> private var context
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.alignment = try container.decodeIfPresent(Alignment.self, forKey: .alignment) ?? .center
        self.content = try container.decode(String.self, forKey: .content)
    }
    
    func body(content: Content) -> some View {
        content.chartOverlay(alignment: alignment) { _ in
            context.buildChildren(of: element, forTemplate: self.content)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case alignment
        case content
    }
}
