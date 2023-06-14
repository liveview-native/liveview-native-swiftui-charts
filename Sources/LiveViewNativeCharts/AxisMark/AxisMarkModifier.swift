//
//  File.swift
//  
//
//  Created by Carson.Katri on 6/14/23.
//

import Charts

/// A modifier that applies to a `AxisMark`.
///
/// Swift Charts does not have its own `AxisMarkModifier` protocol,
/// and instead relies on extensions of `AxisMark` to add modifiers.
///
/// Having types for each modifier is necessary for decoding.
protocol AxisMarkModifier {
    associatedtype AxisMarkModifierBody: AxisMark
    @AxisMarkBuilder
    func body(content: Content) -> AxisMarkModifierBody
}

extension AxisMarkModifier {
    typealias Content = AnyAxisMark
}

@resultBuilder
enum AxisMarkModifierBuilder {
    static func buildBlock<M>(_ modifier: M) -> M where M: AxisMarkModifier {
        modifier
    }
    
    static func buildEither<TrueModifier, FalseModifier>(
        first: @autoclosure () throws -> TrueModifier
    ) rethrows -> _ConditionalAxisMarkModifier<TrueModifier, FalseModifier>
        where TrueModifier: AxisMarkModifier, FalseModifier: AxisMarkModifier
    {
        _ConditionalAxisMarkModifier(storage: .trueModifier(try first()))
    }
    
    static func buildEither<TrueModifier, FalseModifier>(
        second: @autoclosure () throws -> FalseModifier
    ) rethrows -> _ConditionalAxisMarkModifier<TrueModifier, FalseModifier>
        where TrueModifier: AxisMarkModifier, FalseModifier: AxisMarkModifier
    {
        _ConditionalAxisMarkModifier(storage: .falseModifier(try second()))
    }
    
    static func buildOptional<M>(_ component: M?) -> _ConditionalAxisMarkModifier<M, EmptyAxisMarkModifier> where M: AxisMarkModifier {
        _ConditionalAxisMarkModifier(storage: component.map({ .trueModifier($0) }) ?? .falseModifier(.init()))
    }
    
    static func buildLimitedAvailability<M>(_ component: M) -> _AnyAxisMarkModifier where M: AxisMarkModifier {
        _AnyAxisMarkModifier(component)
    }
}

struct _AnyAxisMarkModifier: AxisMarkModifier {
    let _body: (AnyAxisMark) -> AnyAxisMark
    
    init(_ modifier: some AxisMarkModifier) {
        self._body = { AnyAxisMark(modifier.body(content: $0)) }
    }
    
    func body(content: Content) -> some AxisMark {
        _body(content)
    }
}

/// A `ChartModifier` that switches between two possible modifier types.
struct _ConditionalAxisMarkModifier<TrueModifier, FalseModifier>: AxisMarkModifier
    where TrueModifier: AxisMarkModifier, FalseModifier: AxisMarkModifier
{
    enum Storage {
        case trueModifier(TrueModifier)
        case falseModifier(FalseModifier)
    }
    
    let storage: Storage
    
    @AxisMarkBuilder
    func body(content: Content) -> some AxisMark {
        switch storage {
        case let .trueModifier(modifier):
            modifier.body(content: content)
        case let .falseModifier(modifier):
            modifier.body(content: content)
        }
    }
}

struct EmptyAxisMarkModifier: AxisMarkModifier {
    func body(content: Content) -> some AxisMark {
        content
    }
}
