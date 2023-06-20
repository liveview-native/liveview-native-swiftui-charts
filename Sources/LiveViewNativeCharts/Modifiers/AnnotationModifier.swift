//
//  AnnotationModifier.swift
//
//
//  Created by Carson.Katri on 6/20/23.
//

import Charts
import SwiftUI
import LiveViewNative

/// Annotate a chart element with custom Views.
///
/// Place an annotation on a mark to annotate it.
/// Provide a key name to the ``content`` argument, and create a nested element with the `template` attribute set to the same key.
///
/// ```html
/// <BarMark
///   ...
///   modifiers={@native |> annotation(content: :icon)}
/// >
///   <Image template={:icon} system-name="flag.fill" />
/// </BarMark>
/// ```
///
/// ## Arguments
/// * ``position``
/// * ``alignment``
/// * ``spacing``
/// * ``content``
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
struct AnnotationModifier: ContentModifier {
    typealias Builder = ChartContentBuilder
    
    /// The position of the annotation with respect to the annotated item. Defaults to `automatic`.
    ///
    /// See ``LiveViewNativeCharts/Charts/AnnotationPosition`` for a list of possible values.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private let position: AnnotationPosition
    
    /// The alignment of the annotation with respect to the annotated item. Defaults to `center`.
    ///
    /// See ``LiveViewNative/SwiftUI/Alignment`` for a list of possible values.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private let alignment: Alignment
    
    /// The space between the annotation and the annotated item.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private let spacing: CGFloat?
    
    /// `overflow_resolution`, the method used to resolve annotations that do not fit within the chart. Defaults to `automatic`.
    ///
    /// See ``OverflowResolution`` for more details.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private let overflowResolution: OverflowResolution?
    
    /// The key name of the content to place in the annotation.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private let content: String
    
    func apply<R: RootRegistry>(
        to content: Builder.Content,
        on element: ElementNode,
        in context: Builder.Context<R>
    ) -> Builder.Content {
        if #available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *),
           let overflowResolution = overflowResolution?.value
        {
            #if swift(>=5.9)
            return content
                .annotation(
                    position: position,
                    alignment: alignment,
                    spacing: spacing,
                    overflowResolution: overflowResolution
                ) {
                    Builder.buildChildViews(of: element, forTemplate: self.content, in: context)
                }
            #else
            let _ = overflowResolution
            return content
            #endif
        } else {
            return content
                .annotation(
                    position: position,
                    alignment: alignment,
                    spacing: spacing
                ) {
                    Builder.buildChildViews(of: element, forTemplate: self.content, in: context)
                }
        }
    }
}

/// Resolves an annotation that overflows the chart on the `x`/`y` axes.
///
/// Use a tuple where the first element is the `x` strategy is the first element, and the `y` strategy is the second element.
/// Both elements should contain a ``LiveViewNativeCharts/Charts/AnnotationOverflowResolution/Strategy`` type.
///
/// ```elixir
/// {:automatic, :fit}
/// ```
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
struct OverflowResolution: Decodable {
    let _value: Any
    
    #if swift(>=5.9)
    @available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
    var value: AnnotationOverflowResolution {
        _value as! AnnotationOverflowResolution
    }
    #else
    var value: Any { fatalError() }
    #endif
    
    init(from decoder: Decoder) throws {
        #if swift(>=5.9)
        var container = try decoder.unkeyedContainer()
        if #available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *) {
            let x = try container.decode(AnnotationOverflowResolution.Strategy.self)
            let y = try container.decode(AnnotationOverflowResolution.Strategy.self)
            self._value = AnnotationOverflowResolution(x: x, y: y)
        } else {
            throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath, debugDescription: "AnnotationOverflowResolution is only available on iOS 17, macOS 14, tvOS 17, and watchOS 10 or higher."))
        }
        #else
        fatalError()
        #endif
    }
}

#if swift(>=5.9)
/// The strategy used to resolve an overflowing annotation.
///
/// Possible values:
/// * `automatic`
/// * `disabled`
/// * `fit`, `{:fit, boundary}` - See ``LiveViewNativeCharts/Charts/AnnotationOverflowResolution/Boundary`` for a list of possible values.
/// * `pad_scale`
@_documentation(visibility: public)
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension AnnotationOverflowResolution.Strategy: Decodable {
    public init(from decoder: Decoder) throws {
        if var container = try? decoder.unkeyedContainer() {
            switch try container.decode(String.self) {
            case "fit":
                self = .fit(to: try container.decode(AnnotationOverflowResolution.Boundary.self))
            case let `default`:
                throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath, debugDescription: "Unknown strategy '\(`default`)'"))
            }
        } else {
            let container = try decoder.singleValueContainer()
            switch try container.decode(String.self) {
            case "automatic":
                self = .automatic
            case "disabled":
                self = .disabled
            case "fit":
                self = .fit
            case "pad_scale":
                self = .padScale
            case let `default`:
                throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath, debugDescription: "Unknown strategy '\(`default`)'"))
            }
        }
    }
}

/// The boundary to fit to.
///
/// Possible values:
/// * `automatic`
/// * `chart`
/// * `plot`
@_documentation(visibility: public)
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension AnnotationOverflowResolution.Boundary: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        switch try container.decode(String.self) {
        case "automatic":
            self = .automatic
        case "chart":
            self = .chart
        case "plot":
            self = .plot
        case let `default`:
            throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath, debugDescription: "Unknown boundary '\(`default`)'"))
        }
    }
}
#endif
