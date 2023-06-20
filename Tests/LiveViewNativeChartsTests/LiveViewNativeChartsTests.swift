import XCTest
@testable import LiveViewNativeCharts
import SwiftUI
import Charts

final class LiveViewNativeChartsTests: XCTestCase {
    enum SampleData {
        static let scalar = [
            (x: 0.0, y: 0.00),
            (x: 1.0, y: 0.50),
            (x: 2.0, y: 0.25),
            (x: 3.0, y: 1.00),
            (x: 4.0, y: 0.75),
            (x: 5.0, y: 1.10)
        ]
        static let series = [
            (series: "Widgets", x: 0.0, y: 0.00),
            (series: "Widgets", x: 1.0, y: 0.50),
            (series: "Widgets", x: 2.0, y: 0.40),
            
            (series: "Gadgets", x: 0.0, y: 0.25),
            (series: "Gadgets", x: 1.0, y: 1.00),
            (series: "Gadgets", x: 2.0, y: 0.60),
            
            (series: "Gizmos",  x: 0.0, y: 0.75),
            (series: "Gizmos",  x: 1.0, y: 0.50),
            (series: "Gizmos",  x: 2.0, y: 0.80)
        ]
        static let range = [
            (x: 0.0, yStart: 0.00, yEnd: 0.10),
            (x: 1.0, yStart: 0.50, yEnd: 0.60),
            (x: 2.0, yStart: 0.25, yEnd: 0.35),
            (x: 3.0, yStart: 1.00, yEnd: 1.10),
            (x: 4.0, yStart: 0.75, yEnd: 0.85),
            (x: 5.0, yStart: 1.10, yEnd: 1.20)
        ]
        static let seriesRange = [
            (series: "Widgets", x: 0.0, yStart: 0.00, yEnd: 0.10),
            (series: "Widgets", x: 1.0, yStart: 0.50, yEnd: 0.60),
            (series: "Widgets", x: 2.0, yStart: 0.40, yEnd: 0.50),
            
            (series: "Gadgets", x: 0.0, yStart: 0.25, yEnd: 0.35),
            (series: "Gadgets", x: 1.0, yStart: 1.00, yEnd: 1.10),
            (series: "Gadgets", x: 2.0, yStart: 0.60, yEnd: 0.70),
            
            (series: "Gizmos",  x: 0.0, yStart: 0.75, yEnd: 0.85),
            (series: "Gizmos",  x: 1.0, yStart: 0.50, yEnd: 0.60),
            (series: "Gizmos",  x: 2.0, yStart: 0.80, yEnd: 0.90)
        ]
    }
    
    func testSimpleChart() async throws {
        try await assertMatch(
            #"""
            <BarMark x="0" x:label="X" y="0" y:label="Y" />
            <BarMark x="1" x:label="X" y="1" y:label="Y" />
            """#
        ) {
            BarMark(x: .value("X", 0.0), y: .value("Y", 0.0))
            BarMark(x: .value("X", 1.0), y: .value("Y", 1.0))
        }
    }
    
    func testAreaMark() async throws {
        try await assertMatch(
            SampleData.scalar.map {
                #"<AreaMark x="\#($0.x)" x:label="X" y="\#($0.y)" y:label="Y" />"#
            }.joined(separator: "\n")
        ) {
            ForEach(SampleData.scalar, id: \.x) {
                AreaMark(x: .value("X", $0.x), y: .value("Y", $0.y))
            }
        }
        // series
        try await assertMatch(
            SampleData.series.map {
                #"<AreaMark x="\#($0.x)" x:label="X" y="\#($0.y)" y:label="Y" series="\#($0.series)" series:label="Series" />"#
            }.joined(separator: "\n")
        ) {
            ForEach(Array(SampleData.series.enumerated()), id: \.offset) { (_, element) in
                AreaMark(x: .value("X", element.x), y: .value("Y", element.y), series: .value("Series", element.series))
            }
        }
        // range
        try await assertMatch(
            SampleData.range.map {
                #"<AreaMark x="\#($0.x)" x:label="X" y-start="\#($0.yStart)" y-start:label="Y Start" y-end="\#($0.yEnd)" y-end:label="Y End" />"#
            }.joined(separator: "\n")
        ) {
            ForEach(SampleData.range, id: \.x) {
                AreaMark(x: .value("X", $0.x), yStart: .value("Y Start", $0.yStart), yEnd: .value("Y End", $0.yEnd))
            }
        }
        // seriesRange
        try await assertMatch(
            SampleData.seriesRange.map {
                #"<AreaMark x="\#($0.x)" x:label="X" y-start="\#($0.yStart)" y-start:label="Y Start" y-end="\#($0.yEnd)" y-end:label="Y End" series="\#($0.series)" series:label="Series" />"#
            }.joined(separator: "\n")
        ) {
            ForEach(Array(SampleData.seriesRange.enumerated()), id: \.offset) { (_, element) in
                AreaMark(x: .value("X", element.x), yStart: .value("Y Start", element.yStart), yEnd: .value("Y End", element.yEnd), series: .value("Series", element.series))
            }
        }
    }
    
    func testBarMark() async throws {
        try await assertMatch(
            SampleData.scalar.map {
                #"<BarMark x="\#($0.x)" x:label="X" y="\#($0.y)" y:label="Y" />"#
            }.joined(separator: "\n")
        ) {
            ForEach(SampleData.scalar, id: \.x) {
                BarMark(x: .value("X", $0.x), y: .value("Y", $0.y))
            }
        }
        // range
        try await assertMatch(
            SampleData.range.map {
                #"<BarMark x="\#($0.x)" x:label="X" y-start="\#($0.yStart)" y-start:label="Y Start" y-end="\#($0.yEnd)" y-end:label="Y End" />"#
            }.joined(separator: "\n")
        ) {
            ForEach(SampleData.range, id: \.x) {
                BarMark(x: .value("X", $0.x), yStart: .value("Y Start", $0.yStart), yEnd: .value("Y End", $0.yEnd))
            }
        }
    }
    
    func testLineMark() async throws {
        try await assertMatch(
            SampleData.scalar.map {
                #"<LineMark x="\#($0.x)" x:label="X" y="\#($0.y)" y:label="Y" />"#
            }.joined(separator: "\n")
        ) {
            ForEach(SampleData.scalar, id: \.x) {
                LineMark(x: .value("X", $0.x), y: .value("Y", $0.y))
            }
        }
        // series
        try await assertMatch(
            SampleData.series.map {
                #"<LineMark x="\#($0.x)" x:label="X" y="\#($0.y)" y:label="Y" series="\#($0.series)" series:label="Series" />"#
            }.joined(separator: "\n")
        ) {
            ForEach(Array(SampleData.series.enumerated()), id: \.offset) { (_, element) in
                LineMark(x: .value("X", element.x), y: .value("Y", element.y), series: .value("Series", element.series))
            }
        }
    }
    
    func testPointMark() async throws {
        try await assertMatch(
            SampleData.scalar.map {
                #"<PointMark x="\#($0.x)" x:label="X" y="\#($0.y)" y:label="Y" />"#
            }.joined(separator: "\n")
        ) {
            ForEach(SampleData.scalar, id: \.x) {
                PointMark(x: .value("X", $0.x), y: .value("Y", $0.y))
            }
        }
    }
    
    func testRectangleMark() async throws {
        try await assertMatch(
            SampleData.scalar.map {
                #"<RectangleMark x="\#($0.x)" x:label="X" y="\#($0.y)" y:label="Y" />"#
            }.joined(separator: "\n")
        ) {
            ForEach(SampleData.scalar, id: \.x) {
                RectangleMark(x: .value("X", $0.x), y: .value("Y", $0.y))
            }
        }
        // range
        try await assertMatch(
            SampleData.range.map {
                #"<RectangleMark x="\#($0.x)" x:label="X" y-start="\#($0.yStart)" y-start:label="Y Start" y-end="\#($0.yEnd)" y-end:label="Y End" />"#
            }.joined(separator: "\n")
        ) {
            ForEach(SampleData.range, id: \.x) {
                RectangleMark(x: .value("X", $0.x), yStart: .value("Y Start", $0.yStart), yEnd: .value("Y End", $0.yEnd))
            }
        }
    }
    
    func testRuleMark() async throws {
        // range
        try await assertMatch(
            SampleData.range.map {
                #"<RuleMark x="\#($0.x)" x:label="X" y-start="\#($0.yStart)" y-start:label="Y Start" y-end="\#($0.yEnd)" y-end:label="Y End" />"#
            }.joined(separator: "\n")
        ) {
            ForEach(SampleData.range, id: \.x) {
                RuleMark(x: .value("X", $0.x), yStart: .value("Y Start", $0.yStart), yEnd: .value("Y End", $0.yEnd))
            }
        }
    }
}
