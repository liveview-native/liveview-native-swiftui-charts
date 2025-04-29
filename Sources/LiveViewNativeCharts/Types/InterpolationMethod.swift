//
//  InterpolationMethod.swift
//
//
//  Created by Carson Katri on 6/28/23.
//

import Charts
import LiveViewNative
import LiveViewNativeStylesheet

extension InterpolationMethod {
    @ASTDecodable("InterpolationMethod")
    enum Resolvable: @preconcurrency Decodable, StylesheetResolvable {
        case cardinal
        case catmullRom
        case linear
        case monotone
        case stepCenter
        case stepEnd
        case stepStart
        
        func resolve<R>(on element: ElementNode, in context: LiveContext<R>) -> InterpolationMethod where R : RootRegistry {
            switch self {
            case .cardinal:
                return .cardinal
            case .catmullRom:
                return .catmullRom
            case .linear:
                return .linear
            case .monotone:
                return .monotone
            case .stepCenter:
                return .stepCenter
            case .stepEnd:
                return .stepEnd
            case .stepStart:
                return .stepStart
            }
        }
    }
}
