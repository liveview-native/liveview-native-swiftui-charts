//
//  AnnotationPosition.swift
//
//
//  Created by Carson Katri on 5/16/24.
//

import Charts
import LiveViewNativeStylesheet

/// See [`Charts.AnnotationPosition`](https://developer.apple.com/documentation/charts/AnnotationPosition) for more details.
///
/// Possible values:
/// * `.automatic`
/// * `.overlay`
/// * `.top`
/// * `.bottom`
/// * `.leading`
/// * `.trailing`
/// * `.topLeading`
/// * `.topTrailing`
/// * `.bottomLeading`
/// * `.bottomTrailing`
extension AnnotationPosition: ParseableModifierValue {
    public static func parser(in context: ParseableModifierContext) -> some Parser<Substring.UTF8View, Self> {
        ImplicitStaticMember([
            "automatic": .automatic,
            "overlay": .overlay,
            "top": .top,
            "bottom": .bottom,
            "leading": .leading,
            "trailing": .trailing,
            "topLeading": .topLeading,
            "topTrailing": .topTrailing,
            "bottomLeading": .bottomLeading,
            "bottomTrailing": .bottomTrailing,
        ])
    }
}
