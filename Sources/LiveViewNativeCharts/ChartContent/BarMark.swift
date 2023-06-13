//
//  BarMark.swift
//
//
//  Created by Carson Katri on 6/13/23.
//

import Charts
import SwiftUI
import LiveViewNative

extension BarMark: SimpleMark {
    init<X, Y>(element: ElementNode, x: PlottableValue<X>, y: PlottableValue<Y>) where X : Plottable, Y : Plottable {
        self.init(
            x: x,
            y: y,
            width: (try? element.attributeValue(MarkDimension.self, for: "width")) ?? .automatic,
            height: (try? element.attributeValue(MarkDimension.self, for: "height")) ?? .automatic,
            stacking: (try? element.attributeValue(MarkStackingMethod.self, for: "stacking")) ?? .standard
        )
    }
}

extension BarMark: RangeMark {
    init<X, Y>(element: ElementNode, x: PlottableValue<X>, yStart: PlottableValue<Y>, yEnd: PlottableValue<Y>) where X : Plottable, Y : Plottable {
        self.init(
            x: x,
            yStart: yStart,
            yEnd: yEnd,
            width: (try? element.attributeValue(MarkDimension.self, for: "width")) ?? .automatic
        )
    }
    
    init<X, Y>(element: ElementNode, xStart: PlottableValue<X>, xEnd: PlottableValue<X>, y: PlottableValue<Y>) where X : Plottable, Y : Plottable {
        self.init(
            xStart: xStart,
            xEnd: xEnd,
            y: y,
            height: (try? element.attributeValue(MarkDimension.self, for: "height")) ?? .automatic
        )
    }
}

extension BarMark: FixedRangeMark {
    init<X>(element: ElementNode, x: PlottableValue<X>, yStart: CGFloat?, yEnd: CGFloat?) where X : Plottable {
        self.init(
            x: x,
            yStart: yStart,
            yEnd: yEnd,
            width: (try? element.attributeValue(MarkDimension.self, for: "width")) ?? .automatic,
            stacking: (try? element.attributeValue(MarkStackingMethod.self, for: "stacking")) ?? .standard
        )
    }
    
    init<Y>(element: ElementNode, xStart: CGFloat?, xEnd: CGFloat?, y: PlottableValue<Y>) where Y : Plottable {
        self.init(
            xStart: xStart,
            xEnd: xEnd,
            y: y,
            height: (try? element.attributeValue(MarkDimension.self, for: "height")) ?? .automatic,
            stacking: (try? element.attributeValue(MarkStackingMethod.self, for: "stacking")) ?? .standard
        )
    }
}

extension BarMark: FixedBidirectionalRangeMark {
    init<X>(element: ElementNode, xStart: PlottableValue<X>, xEnd: PlottableValue<X>, yStart: CGFloat?, yEnd: CGFloat?) where X : Plottable {
        self.init(
            xStart: xStart,
            xEnd: xEnd,
            yStart: yStart,
            yEnd: yEnd
        )
    }
    
    init<Y>(element: ElementNode, xStart: CGFloat?, xEnd: CGFloat?, yStart: PlottableValue<Y>, yEnd: PlottableValue<Y>) where Y : Plottable {
        self.init(
            xStart: xStart,
            xEnd: xEnd,
            yStart: yStart,
            yEnd: yEnd
        )
    }
}
