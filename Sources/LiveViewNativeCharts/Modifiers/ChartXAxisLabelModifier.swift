//
//  ChartXAxisLabelModifier.swift
//  
//
//  Created by murtza on 07/07/2023.
//

import Charts
import SwiftUI
import LiveViewNative

/// Adds a string as x axis label for charts in the view.
/// ```html
/// <Chart modifiers={chart_x_axis_label(@native, title: "ABC")}>
///   ...
/// </Chart>
/// ```
///
/// Adds a template as x axis label for charts in the view.
/// ```html
/// <Chart modifiers={chart_x_axis_label(@native, content: :my_label)}>
///   <Text template={:my_label}>ABC</Text>
///   ...
/// </Chart>
/// ```
///
/// ## Arguments
/// * ``title``
/// * ``position``
/// * ``alignment``
/// * ``spacing``
/// * ``content``
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
struct ChartXAxisLabelModifier<R: RootRegistry>: ViewModifier, Decodable {
    /// The label string..
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private var title: String?
    
    /// The position of the label.
    ///
    /// See ``LiveViewNativeCharts/Charts/AnnotationPosition`` for a list of possible values.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private var position: AnnotationPosition
    
    /// The alignment of the label.
    ///
    /// See ``LiveViewNativeCharts/LiveViewNative/SwiftUI/Alignment`` for a list of possible values.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private var alignment: Alignment?
    
    /// The spacing of the label from the axis markers.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private var spacing: CGFloat?
    
    /// The label content.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private var content: String?
    
    @ObservedElement(observeChildren: true) private var element
    @ContentBuilderContext<R> private var context
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.position = try container.decodeIfPresent(AnnotationPosition.self, forKey: .position) ?? .automatic
        self.alignment = try container.decodeIfPresent(Alignment.self, forKey: .alignment)
        self.spacing = try container.decodeIfPresent(CGFloat.self, forKey: .spacing)
        self.content = try container.decode(String.self, forKey: .content)
    }
    
    func body(content: Content) -> some View {
        if let title {
            switch (alignment, spacing) {
            case (nil, nil):
                content.chartXAxisLabel(title, position: position)
            case let (alignment?, nil):
                content.chartXAxisLabel(title, position: position, alignment: alignment)
            case let (nil, spacing?):
                content.chartXAxisLabel(title, position: position, spacing: spacing)
            case let (alignment?, spacing?):
                content.chartXAxisLabel(title, position: position, alignment: alignment, spacing: spacing)
            }
        } else if let template = self.content {
            switch (alignment, spacing) {
            case (nil, nil):
                content.chartXAxisLabel(position: position) {
                    context.buildChildren(of: element, forTemplate: template)
                }
            case let (alignment?, nil):
                content.chartXAxisLabel(position: position, alignment: alignment) {
                    context.buildChildren(of: element, forTemplate: template)
                }
            case let (nil, spacing?):
                content.chartXAxisLabel(position: position, spacing: spacing) {
                    context.buildChildren(of: element, forTemplate: template)
                }
            case let (alignment?, spacing?):
                content.chartXAxisLabel(position: position, alignment: alignment, spacing: spacing) {
                    context.buildChildren(of: element, forTemplate: template)
                }
            }
        } else {
            content
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case position
        case alignment
        case spacing
        case content
    }
}
