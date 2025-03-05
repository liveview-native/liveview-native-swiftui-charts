//
//  AnnotationPosition.swift
//
//
//  Created by Carson Katri on 5/16/24.
//

import Charts
import LiveViewNative
import LiveViewNativeStylesheet
import LiveViewNativeCore

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
extension AnnotationPosition {
    @ASTDecodable("AnnotationPosition")
    enum Resolvable: @preconcurrency AttributeDecodable, StylesheetResolvable, @preconcurrency Decodable {
        case automatic
        case overlay
        case top
        case bottom
        case leading
        case trailing
        case topLeading
        case topTrailing
        case bottomLeading
        case bottomTrailing
    }
}

extension AnnotationPosition.Resolvable {
    func resolve<R: RootRegistry>(on element: ElementNode, in context: LiveContext<R>) -> AnnotationPosition {
        switch self {
        case .automatic:
            return .automatic
        case .overlay:
            return .overlay
        case .top:
            return .top
        case .bottom:
            return .bottom
        case .leading:
            return .leading
        case .trailing:
            return .trailing
        case .topLeading:
            return .topLeading
        case .topTrailing:
            return .topTrailing
        case .bottomLeading:
            return .bottomLeading
        case .bottomTrailing:
            return .bottomTrailing
        }
    }
    
    init(from attribute: Attribute?, on element: ElementNode) throws {
        switch attribute?.value {
        case "automatic":
            self = .automatic
        case "overlay":
            self = .overlay
        case "top":
            self = .top
        case "bottom":
            self = .bottom
        case "leading":
            self = .leading
        case "trailing":
            self = .trailing
        case "topLeading":
            self = .topLeading
        case "topTrailing":
            self = .topTrailing
        case "bottomLeading":
            self = .bottomLeading
        case "bottomTrailing":
            self = .bottomTrailing
        default:
            throw AttributeDecodingError.badValue(Self.self)
        }
    }
}
