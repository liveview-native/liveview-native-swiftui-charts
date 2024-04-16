# ``LiveViewNativeCharts``

`liveview-native-swiftui-charts` is an add-on library for [LiveView Native](https://github.com/liveview-native/live_view_native). It adds [Swift Charts](https://developer.apple.com/documentation/charts) support for data visualization.

## Usage

Import `LiveViewNativeCharts` and add the `ChartsRegistry` to the list of addons on your `LiveView`:

```swift
import SwiftUI
import LiveViewNative
import LiveViewNativeCharts

struct ContentView: View {
    var body: some View {
        #LiveView(
            .localhost,
            addons: [ChartsRegistry<_>.self]
        )
    }
}
```

Now you can use the `Chart` element in your template.

<table>

<tr>
<td>

```heex
<Chart>
  <BarMark
    :for={item <- @data}

    x:label="Department"
    x:value={item.department}

    y:label="Profit"
    y:value={item.profit}

    class="fg-product-category"
    product-category={item.product_category}
  />
</Chart>
```
```ex
~SHEET"""
"fg-product-category" do
  foregroundStyle(by: .value("Product Category", attr("product-category")))
end
"""
```

</td>

<td>
<img src="./docs/example.png" alt="LiveView Native Charts screenshot" width="300" />
</td>

</tr>

</table>

## Topics
### Elements
- ``Chart``
### Chart Content
- <doc:Marks>
### Axis Content
- <doc:ConfiguringAxes>
