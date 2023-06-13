# liveview-native-swiftui-charts

## About

`liveview-native-swiftui-charts` is an add-on library for [LiveView Native](https://github.com/liveview-native/live_view_native). It adds [Swift Charts](https://developer.apple.com/documentation/charts) support for data visualization.

## Usage

Add this library as a package to your LiveView Native application's Xcode project using its repo URL. Then, create an `AggregateRegistry` to include the provided `ChartsRegistry` within your native app builds:

```diff
import SwiftUI
import LiveViewNative
+ import LiveViewNativeCharts
+ 
+ struct MyRegistry: CustomRegistry {
+     typealias Root = AppRegistries
+ }
+ 
+ struct AppRegistries: AggregateRegistry {
+     #Registries<
+         MyRegistry,
+         ChartsRegistry<Self>
+     >
+ }

@MainActor
struct ContentView: View {
-     @StateObject private var session: LiveSessionCoordinator<EmptyRegistry> = {
+     @StateObject private var session: LiveSessionCoordinator<AppRegistries> = {
        var config = LiveSessionConfiguration()
        config.navigationMode = .enabled
        
        return LiveSessionCoordinator(URL(string: "http://localhost:4000/")!, config: config)
    }()

    var body: some View {
        LiveView(session: session)
    }
}
```

To render a chart within a SwiftUI HEEx template, use the `Chart` element.
Include mark elements within the chart to display some data:

```elixir
defmodule MyAppWeb.ChartLive do
  use Phoenix.LiveView
  use LiveViewNative.LiveView

  def mount(_params, _session, socket) do
    {:ok, assign(socket, data: [
      %{ department: "Production", profit: 4000, product_category: "Gizmos" },
      %{ department: "Marketing", profit: 2000, product_category: "Gizmos" },
      %{ department: "Finance", profit: 2000, product_category: "Gizmos" },
      ...
    ])}
  end

  @impl true
  def render(%{platform_id: :swiftui} = assigns) do
    ~Z"""
    <Chart>
      <%= for item <- @data do %>
        <BarMark
          x={item.department}
          x:label="Department"

          y={item.profit}
          y:label="Profit"

          modifiers={@native |> foreground_style(value: {"Product Category", item.product_category})}
        />
      <% end %>
    </Chart>
    """swiftui
  end
end
```

![LiveView Native Charts screenshot](./docs/example.png)

## Learn more

  * Official website: https://native.live
  * Docs: https://hexdocs.pm/live_view_native_platform
  * Source: https://github.com/liveviewnative/live_view_native_platform
