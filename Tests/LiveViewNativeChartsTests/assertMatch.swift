//
//  assertMatch.swift
//
//
//  Created by Carson Katri on 6/20/23.
//

import XCTest
@testable import LiveViewNativeCharts
@testable import LiveViewNative
import LiveViewNativeCore
import SwiftUI
import Charts

struct ChartSnapshotHost: View {
    let document: Document
    @ContentBuilderContext<EmptyRegistry, LiveViewNativeCharts.ChartContentBuilder> private var context
    
    var body: some View {
        Charts.Chart {
            AnyChartContent(
                try! LiveViewNativeCharts.ChartContentBuilder.build(document[document.root()].children(), in: context)
            )
        }
    }
}

extension XCTestCase {
    @MainActor
    func assertMatch(
        lifetime: XCTAttachment.Lifetime = .deleteOnSuccess,
        _ markup: String,
        @Charts.ChartContentBuilder _ chart: () -> some ChartContent
    ) async throws {
        let chartRenderer = ImageRenderer(content: Charts.Chart {
            chart()
        })
        
        guard let chartImage = chartRenderer.uiImage
        else { return XCTAssert(false, "Failed to render reference image") }
        
        let chartAttachment = XCTAttachment(image: chartImage)
        chartAttachment.name = "Reference Image"
        chartAttachment.lifetime = lifetime
        self.add(chartAttachment)
        
        let session = LiveSessionCoordinator<EmptyRegistry>(URL(string: "http://localhost")!)
        let document = try LiveViewNativeCore.Document.parse(markup)
        let markupRenderer = ImageRenderer(content: ChartSnapshotHost(document: document)
            .environment(\.coordinatorEnvironment, CoordinatorEnvironment(session.navigationPath.first!.coordinator, document: document))
            .environment(\.anyLiveContextStorage, LiveContextStorage(coordinator: session.navigationPath.first!.coordinator, url: session.url))
        )
        
        guard let markupImage = markupRenderer.uiImage
        else { return XCTAssert(false, "Failed to render markup image") }
        
        let markupAttachment = XCTAttachment(image: markupImage)
        markupAttachment.name = "Markup Image"
        markupAttachment.lifetime = lifetime
        self.add(markupAttachment)
        
        XCTAssertEqual(markupImage.pngData()!, chartImage.pngData()!)
    }
}
