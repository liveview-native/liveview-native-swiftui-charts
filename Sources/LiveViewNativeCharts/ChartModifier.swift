//
//  ChartModifier.swift
//
//
//  Created by Carson Katri on 6/8/23.
//

import Charts

/// A modifier that applies to a `Chart`.
///
/// Swift Charts does not have its own `ChartModifier` protocol,
/// and instead relies on extensions of `ChartContent` to add modifiers.
///
/// Having types for each modifier is necessary for decoding.
protocol ChartModifier {
    associatedtype Body: ChartContent
    
    @ChartContentBuilder
    func body(content: Content) -> Body
}

extension ChartModifier {
    typealias Content = AnyChartContent
}

@resultBuilder
enum ChartModifierBuilder {
    static func buildBlock<M>(_ modifier: M) -> M where M: ChartModifier {
        modifier
    }
    
    static func buildEither<TrueModifier, FalseModifier>(
        first: @autoclosure () throws -> TrueModifier
    ) rethrows -> _ConditionalModifier<TrueModifier, FalseModifier>
        where TrueModifier: ChartModifier, FalseModifier: ChartModifier
    {
        _ConditionalModifier(storage: .trueModifier(try first()))
    }
    
    static func buildEither<TrueModifier, FalseModifier>(
        second: @autoclosure () throws -> FalseModifier
    ) rethrows -> _ConditionalModifier<TrueModifier, FalseModifier>
        where TrueModifier: ChartModifier, FalseModifier: ChartModifier
    {
        _ConditionalModifier(storage: .falseModifier(try second()))
    }
    
    static func buildOptional<M>(_ component: M?) -> _ConditionalModifier<M, EmptyChartModifier> where M: ChartModifier {
        _ConditionalModifier(storage: component.map({ .trueModifier($0) }) ?? .falseModifier(.init()))
    }
    
    static func buildLimitedAvailability<M>(_ component: M) -> _AnyChartModifier where M: ChartModifier {
        _AnyChartModifier(component)
    }
}

struct _AnyChartModifier: ChartModifier {
    let _body: (AnyChartContent) -> AnyChartContent
    
    init(_ modifier: some ChartModifier) {
        self._body = { AnyChartContent(modifier.body(content: $0)) }
    }
    
    func body(content: Content) -> some ChartContent {
        _body(content)
    }
}

/// A `ChartModifier` that switches between two possible modifier types.
struct _ConditionalModifier<TrueModifier, FalseModifier>: ChartModifier
    where TrueModifier: ChartModifier, FalseModifier: ChartModifier
{
    enum Storage {
        case trueModifier(TrueModifier)
        case falseModifier(FalseModifier)
    }
    
    let storage: Storage
    
    @ChartContentBuilder
    func body(content: Content) -> some ChartContent {
        switch storage {
        case let .trueModifier(modifier):
            modifier.body(content: content)
        case let .falseModifier(modifier):
            modifier.body(content: content)
        }
    }
}

struct EmptyChartModifier: ChartModifier {
    func body(content: Content) -> some ChartContent {
        content
    }
}
