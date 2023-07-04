//
//  AnnotationPosition.swift
//
//
//  Created by Carson Katri on 6/20/23.
//

import Charts

/// The placement of an annotation relative to the annotated item.
///
/// Possible values:
/// * `automatic`
/// * `overlay`
/// * `top`
/// * `bottom`
/// * `leading`
/// * `trailing`
/// * `top_leading`
/// * `top_trailing`
/// * `bottom_leading`
/// * `bottom_trailing`
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
extension AnnotationPosition: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        switch try container.decode(String.self) {
        case "automatic": self = .automatic
        case "overlay": self = .overlay
        case "top": self = .top
        case "bottom": self = .bottom
        case "leading": self = .leading
        case "trailing": self = .trailing
        case "top_leading": self = .topLeading
        case "top_trailing": self = .topTrailing
        case "bottom_leading": self = .bottomLeading
        case "bottom_trailing": self = .bottomTrailing
        case let `default`:
            throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath, debugDescription: "Unknown annotation position '\(`default`)'"))
        }
    }
}
