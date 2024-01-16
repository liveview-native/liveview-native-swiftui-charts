//
//  InterpolationMethod.swift
//
//
//  Created by Carson Katri on 6/28/23.
//

import Charts
import LiveViewNative
import LiveViewNativeStylesheet

extension InterpolationMethod: ParseableModifierValue {
    public static func parser(in context: ParseableModifierContext) -> some Parser<Substring.UTF8View, Self> {
        ImplicitStaticMember([
            "cardinal": .cardinal,
            "catmullRom": .catmullRom,
            "linear": .linear,
            "monotone": .monotone,
            "stepCenter": .stepCenter,
            "stepEnd": .stepEnd,
            "stepStart": .stepStart,
            
            
        ])
    }
}
