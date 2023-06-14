//
//  File.swift
//  
//
//  Created by Carson.Katri on 6/14/23.
//

import Charts
import SwiftUI

// this modifier is created by `liveview-client-swiftui`, and an implementation for Charts is provided here.
/// Sets the font of an axis mark.
///
/// Use this modifier on an axis mark to set the font.
///
/// ```html
/// <AxisGridLine modifiers={font(@native, font: {:system, :footnote})} />
/// ```
///
/// ## Arguments
/// * ``font``
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
struct FontModifier: AxisMarkModifier, Decodable {
    /// The font to apply.
    ///
    /// See ``LiveViewNativeCharts/LiveViewNative/SwiftUI/Font`` for more details.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private let font: Font

    func body(content: Content) -> some AxisMark {
        content.font(font)
    }
}
