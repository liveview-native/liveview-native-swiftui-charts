//
//  AnnotationPosition.swift
//  
//
//  Created by murtza on 07/07/2023.
//

import Charts
import LiveViewNative
import LiveViewNativeCore

/// The position of an annotation.
///
/// Possible values:
/// * `automatic`
/// * `bottom`
/// * `bottom-leading` or `bottom_leading`
/// * `bottom-trailing` or `bottom_trailing`
/// * `leading`
/// * `overlay`
/// * `top`
/// * `top-leading` or `top_leading`
/// * `top-trailing` or `top_trailing`
/// * `trailing`
extension AnnotationPosition: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        switch try container.decode(String.self) {
        case "automatic": self = .automatic
        case "bottom": self = .bottom
        case "bottom-leading", "bottom_leading": self = .bottomLeading
        case "bottom-trailing", "bottom_trailing": self = .bottomTrailing
        case "leading": self = .leading
        case "overlay": self = .overlay
        case "top": self = .top
        case "top-leading", "top_leading": self = .topLeading
        case "top-trailing", "top_trailing": self = .topTrailing
        case "trailing": self = .trailing
        case let `default`:
            throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath, debugDescription: "Unknown Annotation Position `\(`default`)`"))
        }
    }
}
